module ProMotion; module Menu
  module Transition

     VISUAL_STATES = {
      slide_and_scale: MMDrawerVisualState.slideAndScaleVisualStateBlock,
      slide: MMDrawerVisualState.slideVisualStateBlock,
      parallax: MMDrawerVisualState.parallaxVisualStateBlockWithParallaxFactor(3),
      swinging_door: MMDrawerVisualState.swingingDoorVisualStateBlock
    }

    # slide_and_scale: Creates a slide visual state block that gives the user an experience that slides at the same speed of the center view controller during animation. This is equal to calling parallaxVisualStateBlockWithParallaxFactor: with a parallax factor of 1.0. This is similar to the menu in Spotify's app.
    # parallax: Creates a parallax experience that slides the side drawer view controller at a different rate than the center view controller during animation. For every parallaxFactor of points moved by the center view controller, the side drawer view controller will move 1 point. Passing in 1.0 is the equivalent of a applying a sliding animation, while passing in 'MAX_FLOAT' is the equivalent of having no animation at all.
        # parallaxFactor is fed in by appending an underscore and the factor to 'parallax', i.e. :parallax_6 for a desired parallax factor of 6
    # swinging_door: Creates a swinging door visual state block that gives the user an experience that animates the drawer in along the hinge.
    # slide_and_scale: Creates a slide and scale visual state block that gives an experience similar to Mailbox.app. It scales from 90% to 100%, and translates 50 pixels in the x direction. In addition, it also sets alpha from 0.0 to 1.0.

    def transition_animation=(visual_block)
      # Parallax requires a parallax_factor. Set it by passing the visual_block block in with underscore parallax_factor attached to the end. i.e. transition_animation = :parallax_6 for parallax_factor 6.
      self.setDrawerVisualStateBlock(mask_for_transition(visual_block))
    end

    def mask_for_transition(visual_block)
      unless visual_block.nil?
        if visual_block.include? "parallax"
          parallax_factor = visual_block.include?("_") ? visual_block.split("_")[1].to_i : 3
          visual_state = MMDrawerVisualState.parallaxVisualStateBlockWithParallaxFactor(parallax_factor)
        end
      end
      visual_state ||= VISUAL_STATES[visual_block]
      visual_state
    end

  end
end; end
