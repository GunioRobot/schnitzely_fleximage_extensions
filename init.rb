class Fleximage::Operator::Polaroid < Fleximage::Operator::Base
  def operate(angle_range = 10, border_width = 10)
    @image.border!(border_width, border_width, "#f0f0ff")

    # Bend the image
    @image.background_color = "none"

    amplitude = @image.columns * 0.01        # vary according to taste
    wavelength = @image.rows  * 2

    @image.rotate!(90)
    @image = @image.wave(amplitude, wavelength)
    @image.rotate!(-90)

    # Make the shadow
    shadow = @image.flop
    shadow = shadow.colorize(1, 1, 1, "gray75")     # shadow color can vary to taste
    shadow.background_color = "white"       # was "none"
    shadow.border!(10, 10, "white")
    shadow = shadow.blur_image(0, 3)        # shadow blurriness can vary according to taste

    # Composite image over shadow. The y-axis adjustment can vary according to taste.
    @image = shadow.composite(@image, -amplitude/2, 5, Magick::OverCompositeOp)

    angle_range = angle_range.to_i
    @image.rotate!(rand(angle_range * 2 + 1) - angle_range)                       # vary according to taste
    @image.trim!
  end
end
