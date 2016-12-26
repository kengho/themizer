require_relative "../spec_helper"

describe ThemizerSpec do
  Rake::Task["tmp:cache:clear"].invoke
  Rake::Task["assets:clobber"].invoke
  Rake::Task["assets:precompile"].invoke

  it "should be initialized with Hash with :themes key which is Array if strings", spec00: true do
    expect {
      Themizer.init(false)
    }.to raise_error(
      RuntimeError, Themizer::ARGUMENT_ERROR
    )

    expect {
      Themizer.init({ some_key: false })
    }.to raise_error(
      RuntimeError, Themizer::ARGUMENT_ERROR
    )

    expect {
      Themizer.init({ themes: false })
    }.to raise_error(
      RuntimeError, Themizer::ARGUMENT_ERROR
    )

    expect {
      Themizer.init({ themes: ["theme1", 1] })
    }.to raise_error(
      RuntimeError, Themizer::ARGUMENT_ERROR
    )
  end

  it "should themize single block", spec01: true do
    expect(precompiled_css("spec01")).to eq(fixture_css("spec01"))
  end

  it "shouldn't spoil normal css lines", spec02: true do
    expect(precompiled_css("spec02")).to eq(fixture_css("spec02"))
  end

  it "should themize several blocks in one file", spec03: true do
    expect(precompiled_css("spec03")).to eq(fixture_css("spec03"))
  end

  it "should use default vars in case some themes' vars are undefined", spec04: true do
    expect(precompiled_css("spec04")).to eq(fixture_css("spec04"))
  end

  it "shouldn't spoil other erb expressions inside themize block", spec05: true do
    expect(precompiled_css("spec05")).to eq(fixture_css("spec05"))
  end

  it "shouldn't spoil other erb blocks inside themize block", spec06: true do
    expect(precompiled_css("spec06")).to eq(fixture_css("spec06"))
  end

  it "shouldn't spoil other erb one-line blocks inside themize block", spec07: true do
    expect(precompiled_css("spec07")).to eq(fixture_css("spec07"))
  end

  it "shouldn't spoil other erb one-line blocks inside themize block even they placed unexpectedly", spec08: true do
    expect(precompiled_css("spec08")).to eq(fixture_css("spec08"))
  end

  it "should themize relatively complex scss", spec09: true do
    expect(precompiled_css("spec09")).to eq(fixture_css("spec09"))
  end

  it "shouldn't spoil !important keywork", spec10: true do
    expect(precompiled_css("spec10")).to eq(fixture_css("spec10"))
  end

  it "should expand themized variables into maps", spec11: true do
    expect(precompiled_css("spec11")).to eq(fixture_css("spec11"))
  end

  it "should process comments correctly", spec12: true do
    expect(precompiled_css("spec12")).to eq(fixture_css("spec12"))
  end

  it "should be able to unthemize", spec13: true do
    expect(precompiled_css("spec13")).to eq(fixture_css("spec13"))
  end

  it "should use default \"\" theme in unthemize", spec14: true do
    expect(precompiled_css("spec14")).to eq(fixture_css("spec14"))
  end

  it "should be able to unthemize sass var with tilda into map-get", spec15: true do
    expect(precompiled_css("spec15")).to eq(fixture_css("spec15"))
  end

  # fails; didn't figured out proper way to do that yet
  it "should place class after body tag", spec16: true do
    expect(precompiled_css("spec16")).to eq(fixture_css("spec16"))
  end

  it "should not break on empty blocks", spec17: true do
    expect(precompiled_css("spec17")).to eq(fixture_css("spec17"))
  end
end
