module ProMotion; module Menu
  module Transition

     VISUAL_STATES = {
      slide_and_scale:
        {
          block: MMDrawerVisualState.slideAndScaleVisualStateBlock,
          # "Creates a slide and scale visual state block that gives an experience similar to Mailbox.app. It scales from 90% to 100%, and translates 50 pixels in the x direction. In addition, it also sets alpha from 0.0 to 1.0."
        },
      slide:
        {
          block: MMDrawerVisualState.slideVisualStateBlock,
          # "Creates a slide visual state block that gives the user an experience that slides at the same speed of the center view controller during animation. This is equal to calling parallaxVisualStateBlockWithParallaxFactor: with a parallax factor of 1.0."
        },
      parallax:
        {
          block: MMDrawerVisualState.parallaxVisualStateBlockWithParallaxFactor(3),
          # "Creates a parallax experience that slides the side drawer view controller at a different rate than the center view controller during animation. For every parallaxFactor of points moved by the center view controller, the side drawer view controller will move 1 point. Passing in 1.0 is the equivalent of a applying a sliding animation, while passing in 'MAX_FLOAT' is the equivalent of having no animation at all."
        },
      swinging_door:
        {
          block: MMDrawerVisualState.swingingDoorVisualStateBlock,
          # "Creates a swinging door visual state block that gives the user an experience that animates the drawer in along the hinge."
        }
    }

    def transition_animation=(visualBlock)
      # Parallax requires a parallaxFactor. Set it by passing the visualBlock block in with underscore parallaxFactor attached to the end. i.e. transition_animation = :parallax_6 for parallaxFactor 6.

      self.setDrawerVisualStateBlock(mask_for_transition(visualBlock))
    end

    def mask_for_transition(visualBlock)
      unless visualBlock.nil?
        if visualBlock.include? "parallax"
          parallax_factor = visualBlock.include?("_") ? visualBlock.split("_")[1].to_i : 3
          visual_state = MMDrawerVisualState.parallaxVisualStateBlockWithParallaxFactor(parallax_factor)
        end
      end
      visual_state ||= VISUAL_STATES.keys.include?(visualBlock) ? VISUAL_STATES[visualBlock][:block] : nil
      visual_state
    end

  end
end; end
