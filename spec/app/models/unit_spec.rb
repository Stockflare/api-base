describe Unit do

  let(:quantity) { 52 }

  let(:unit) { create(:unit, quantity: quantity) }

  before { unit.ready! }

  subject { unit }

  it { should respond_to(:within_quantity?) }

  specify { expect { subject.quantity = -1 }.to change { subject.valid? }.from(true).to(false) }

  specify { expect { subject.quantity = 1 }.to_not change { subject.valid? } }

  specify { expect(subject.within_quantity?(quantity)).to be_truthy }

  specify { expect(subject.within_quantity?(quantity / 2)).to be_truthy }

  specify { expect(subject.within_quantity?(quantity + 1)).to be_falsey }

  specify { expect(subject.can_split?(quantity)).to be_falsey }

  specify { expect(subject.can_split?(quantity / 2)).to be_truthy }

  describe 'state transitions' do

    specify { expect(subject.may_purchase?(quantity)).to be_truthy }

    specify { expect(subject.may_purchase?(quantity / 2)).to be_truthy }

    specify { expect(subject.may_purchase?(quantity + 1)).to be_falsey }

    describe 'a purchased unit' do

      specify { expect { subject.purchase!(quantity * 2) }.to raise_error }

      specify { expect { subject.purchase! }.to_not change { Unit.count } }

      specify { expect { subject.purchase! }.to change { subject.purchased? }.from(false).to(true) }

      specify { expect { subject.purchase! }.to_not change { subject.quantity } }

    end

    describe 'a partially purchased unit' do

      specify { expect { subject.purchase!(quantity / 2) }.to change { Unit.count }.by(1) }

      specify { expect { subject.purchase!(quantity / 2) }.to change { subject.purchased? }.from(false).to(true) }

      specify { expect { subject.purchase!(quantity - 2) }.to change { subject.quantity }.by(-2) }

    end

    describe 'a purchased unit flow' do

      before { subject.purchase! }

      specify { expect(subject.may_prepare?).to be_truthy }

      describe 'a preparing unit' do

        before { subject.prepare! }

        specify { expect(subject.packing?).to be_truthy }

        specify { expect(subject.may_dispatch?).to be_truthy }

        describe 'a dispatched unit' do

          before { subject.dispatch! }

          specify { expect(subject.delivering?).to be_truthy }

          specify { expect(subject.may_deliver?).to be_truthy }

          describe 'a delivered unit' do

            before { subject.deliver! }

            specify { expect(subject.delivered?).to be_truthy }

            specify { expect(subject.may_refund?).to be_truthy }

            specify { expect(subject.may_report?).to be_truthy }

            describe 'a partially reported unit' do

              specify { expect { subject.report!(quantity / 2) }.to change { Unit.count }.by(1) }

              specify { expect { subject.report!(quantity / 2) }.to change { subject.quantity }.to(quantity / 2) }

              specify { expect { subject.report!(quantity / 2) }.to change { subject.wasted? }.from(false).to(true) }

            end

            describe 'a partially refunded unit' do

              specify { expect { subject.refund!(quantity / 2) }.to change { Unit.count }.by(1) }

              specify { expect { subject.refund!(quantity / 2) }.to change { subject.quantity }.to(quantity / 2) }

              specify { expect { subject.refund!(quantity / 2) }.to change { subject.returned? }.from(false).to(true) }

            end

          end

        end

      end

    end

    describe 'a splitted unit' do

      let(:new_quantity) { Random.rand(10) }

      specify { expect { subject.splitted!(new_quantity) }.to change { subject.quantity }.from(quantity).to(new_quantity) }

      specify { expect { subject.splitted!(new_quantity) }.to_not change { subject.available? } }

    end

    describe 'a held unit' do

      specify { expect { subject.hold! }.to change { subject.unavailable? }.from(false).to(true) }

    end

  end

end
