class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:normalize_title)

private

  define_method(:normalize_title) do
    self.title = (title().capitalize())
  end

end
