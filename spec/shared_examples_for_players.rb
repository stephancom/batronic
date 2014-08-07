shared_examples_for 'a player' do
  # TODO TEST VALIDATIONS
  it { is_expected.to respond_to(:id)           }
  it { is_expected.to respond_to(:player_key)   }
  it { is_expected.to respond_to(:birth_year)   }
  it { is_expected.to respond_to(:first_name)   }
  it { is_expected.to respond_to(:last_name)    }

  it "should deliver full name" do
    expect(subject.full_name).to eq(full_name)
  end

  it "should give full name and year of birth in to_s" do
    expect(subject.to_s).to match(full_name)
    expect(subject.to_s).to match(subject.birth_year.to_s)
  end
end