module ColorHelper

  def random_rgb_color(range = 255)
    [rand(range), rand(range), rand(range)].map { |color|
      color.to_s(16).rjust(2, 0.to_s)
    }.join
  end

end
