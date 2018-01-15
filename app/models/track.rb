class Track < ApplicationRecord

  SHORT = 180000
  LONG  = 360000

  scope :short,  -> { shorter_than(SHORT) }
  scope :medium, -> { shorter_than(LONG).longer_than_or_equal_to(SHORT) }
  scope :long,   -> { longer_than_or_equal_to(LONG) }
  scope :starts_with, -> (char) { where('name ILIKE ?', "#{ char }%") }





  # scope looks into code and shortens code into one line
  #
  # def self.short
  #   where('milliseconds < ?', SHORT)
  # end
  #
  # def self.medium
  #   where('milliseconds < ?', SHORT)
  #     .where('milliseconds < ?', LONG)
  # end
  #
  # def self.long
  #   where('milliseconds >= ?', LONG)
  # end
  #
  # def self.shorter_than(milliseconds)
  #   if milliseconds && milliseconds >= 0
  #     where('milliseconds < ?', milliseconds)
  #   else # track.all means the same as all
  #     all
  #   end
  # end
  # SAME AS -------------->
  scope :shorter_than, ->(milliseconds) {
    where('milliseconds < ?', milliseconds) if milliseconds && milliseconds >= 0
  
  # def self.longer_than_or_equal_to(milliseconds)
  #   if milliseconds && milliseconds >= 0
  #     where('milliseconds >= ?', milliseconds)
  #   else
  #     all
  #   end
  # end
  # SAME AS-------------->
  scope :longer_than, ->(milliseconds) {
     where('milliseconds >= ?', milliseconds) if milliseconds && milliseconds >= 0
  }


  # def self.starts_with(char)
  #   where('name ILIKE ?', "#{ char }%")
  # end


end
