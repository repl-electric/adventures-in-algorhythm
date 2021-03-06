Zz = [nil]
S = 18
T = 21
REST4=[Zz, 4]
REST8=[Zz, 8]
def dotted(n)
  n+(n/2.0)
end
def cube_hit(inital=0.2, vel=0.2, m=0.8)
  at{
    unity "/cube/hit/speed", vel+rand*0.1
    sleep 0.5
    unity "/cube/hit", inital
    sleep 0.25
    4.times{|n|
      unity "/cube/hit", linear_map(0,3,m,0.03, n)
      sleep 0.25
    }
    unity "/cube/hit", 0.01
  }
end

def crash
  unity "/world/time", 0.015
  burst 1.0
  unity "/cam0/glitch_a", 0.5
  unity "/cam0/glitch_v", 0.5
  star size: 1.5
  sleep 1
  #explode_rocks
  explode_cube
  unity "/shard", 1.0
  unity "/world/time", 0.025
  sleep 2
  unity "/cam0/glitch_a", 0.0
  unity "/cam0/glitch_v", 0.0
end

def recover
  $star_size=2.0
  $pmode=2
  $end=false
  at{

    world time: 0.99
    unity "/cam0/glitch_a", 0.5
    init true
    sleep 1
    unity "/cube/recover", 1.0
    zoomout
    create_cube
    cam :chase
    burst 0.0
    colorb 1.0
    sleep 1
    unity "/cam0/glitch_a", 0.0
    overclock_cc attune: 0.27
    colorb 1.0
  }
end

def mbox_inits
  #mbox_cc motion: 0.30, drive: 1.00, sat: 1.00
  #mbox2_cc sat: 1.00, motion: 0.50, drive: 0.00

  #mbox_cc motion: 0.70, drive: 0.00, sat: 0.00
  #mbox2_cc sat: 1.00, motion: 0.60, drive: 0.00
  #overclock_cc motion: 0.45, drive: 0.60
end
def slow_init
  vortex throttle: 1.0, y: 1.2, force: 100
  star life: 8, size: 0.125
  roots throttle: 1.0, freq: 0.8
  rocks throttle: 1.0
  burst 1.0
end
def start_init
  if $pmode==0
    overclock_cc motion: 0.6, drive: 0.20, fm: 0.00, mode: 0, skip: true
    flop_cc motion: 0.5, sat: 0.00, drive: 0.00, skip: true
    flip_cc  motion: 0.6, skip: true
    resonate_cc amp: 0.85
    overclock_cc amp: 0.8
  end
end
def bright
  star life: 4, size: 15.0 #4
end
def end1
  create_sea -2
  create_tree -2
  create_cube 3
  sea ripple: 13.0
  burst 1.0
  linecolor factor: -10
  rocks orbit: 200.0, throttle: 1.0
  star life: 5, size: 10.0 #4
  roots throttle: 1.0, freq: 1.0, target: :bird, drag: 0.0, swirl: 1.0
  #vortex y: 7.0, force: -400, throttle: 1.0, radius: 4.9, throttle: 1.0
  vortex throttle: 0.0
  rocks throttle: 0.0
  burst 1.0
  unity "/endit", 0.0
  unity "/endit", 1.0
end
def end2
  star life: 5, size: 12.0 #4
  vortex throttle: 0.0
  unity "/enditall",1.0
end
def attune
  at{
    sleep 2
    unity "/attune/noise",1.5
    sleep 16
    unity "/attune/noise",1.2
    sleep 32
    unity "/attune/noise",1.1
  }
  unity "/camptop/arm/rot",4.0
  unity "/camptop/arm/pos",0.0
  unity "/camptop/pivot/pos",1.0
  unity "/camptop/pivot/rot",70.0
  world time: 1
  unity "/attune/flow", 4.5
  unity "/camtop/zoomin",15.0
  unity "/attune",1
  $pmode = 4
end

def zoom_in
  unity "/camtop/zoomin",15.0
end
def deepbase_init
  overclock_cc motion: 1.00, drive: 0.30, fm: 0.00, mode: 0, skip: true
end
def kickviz
  at{
    sleep 0.5
    unity "/star", -0.1
    light size: 0.04

    star throttle: 0.1
    star life: 2.0
    sleep 0.25
    star throttle: 0.02
    sleep 0.25
    light size: 0.0
  }
end
def star(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if (o=opts[:throttle])
    unity "/star/throttle",o
  end
  if (o=opts[:life])
    unity "/star/life",o
  end
  if (o = opts[:size])
    unity "/cubeinside", o
  end
end
def scene(n)
  unity "/scene/#{n}"
end
def burst(n=0.0)
  unity "/burst", n
end
def create_tree(n=0.0)
 unity "/tree", n
end
def create_sea(n=0.0)
 unity "/sea", n
end
def create_light(n=1.0)
 unity "/light", n
end
def create_bird(n=0.0)
  unity "/bird",n
end
def create_island(n=0.0)
  unity "/island",n
end
def create_cube(n=0.0)
  unity "/cube",n
  slice_cube y: 10.0, z: 10.0, cubes: 10.0
  slice_cube y: 0.0, z: 0.0, cubes: 0.0
  star size: 0.0, life: 2.0
end
def explode_cube()
  unity "/cube/explode"
  cube wires: 0.0
  $pmode=-1
  world time: 0.002
end
def explode_world()
  star size: 12, life: 5
  world time: 0.1
  cube wires: 0.0
  $pmode=-1
  unity "/explode2"
end
def explode_aura()
  world time: 0.1
  unity "/explode3"
end
def slice_cube(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if v=opts[:x]
    unity "/cube/split/x", v
  end
  if v=opts[:y]
    unity "/cube/split/y", v
  end
  if v=opts[:z]
    unity "/cube/split/z", v
  end
  if v=opts[:cubes]
    unity "/cube/split/cubes", v
  end
end
def explode_rocks()
  unity "/explode1"
end
def live_code_a(*n)
  create_aura
end
def create_aura(n=0)
  n = n-0.9
  unity "/aura",n
  unity "/cube/aura/globalscale", 0.0
  unity "/cube/aura/scalemul", -0.6
  aura distort: 1
end
def world(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if opts[:lightning]
    at{
      sleep 0.5
      unity "/world/lightning",1.0
    }
  end
  if opts[:time]
    unity "/world/time",opts[:time]
  end
end
def sea(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  at{
    if opts[:delay]
      sleep 0.5
    end
    if o=opts[:wave]
      unity "/sea/waveheight", o
    end
    if o=opts[:ripple]
      unity "/sea/rippleheight", o
    end
    if o=opts[:dir]
      unity "/sea/direction", o
    end
    if o=opts[:circle]
      unity "/sea/circle", o
    end
    if o=opts[:sphere]
      unity "/sea/sphere", o
    end

  }
end
def roots_cube
  roots_chase target: :cube, radius: 0, force: 30, amp: 0.02, drag: 3
end
def roots_chase(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if(o=opts[:throttle])
    unity "/knitroots/throttle", o
  end
  if (o=opts[:radius])
    unity "/knitroots/radius", o
  end
  if (o=opts[:amp])
    unity "/knitroots/amp", o
  end
  if (o=opts[:freq])
    unity "/knitroots/freq", o
  end
  if (o=opts[:thick])
    unity "/knitroots/thick", o
  end
  if (o=opts[:target])
    if o == :spiral
      $chase=true
      rocks orbit: 20
      roots_chase radius: 0.001, force: 20
      unity "/knitroots/target/spiral", 1.0
    elsif o == :cube
      unity "/knitroots/target/cube", 1.0
    elsif o == :none
      unity "/knitroots/target/none", 1.0
    elsif o == :start
      unity "/knitroots/target/start", 1.0
      roots_chase drag: 2, freq: 0.2, amp: 0.1, force: 100
    elsif o == :slow
      unity "/knitroots/target/slow", 1.0
      roots_chase drag: 2.5, freq: 0.05, amp: 0.09, force: 3, radius: 0.0001, noise: 0
    elsif o == :ring
      unity "/knitroots/target/slow", 1.0
      roots_chase drag: 20.5, freq: 0.02, amp: 0.02, force: 80, radius: 0.0001, noise: 0
    end
  end
  if (o=opts[:drag])
    unity "/knitroots/drag", o
  end
  if (o=opts[:force])
    unity "/knitroots/force", o
  end
  if (o=opts[:radius])
    unity "/knitroots/radius", o
  end
end

def roots(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  at{
    if opts[:delay] == true
      sleep 0.5
    end
    if !opts[:alive] && !opts[:chase] && !opts[:swirl]
      if (o=opts[:throttle])
        unity "/roots", o
      end
      if (o=opts[:drag])
        unity "/roots/drag", o
      end
      if (o=opts[:freq])
        unity "/roots/freq", o
      end
      if (o=opts[:target])
        if o == :bird
          unity "/roots/target/bird", 1.0
        end
        if o == :cube
          unity "/roots/target/cube", 0.0
          unity "/roots/target/cube", 1.0
        end
        if o == :frag
          unity "/roots/target/frag", 1.0
        end
      end
    end
    if (o=opts[:swirl])
      unity "/roots/swirl/throttle", o
      if (o=opts[:amp])
        unity "/roots/swirl/amp", o
      end
      if (o=opts[:drag])
        unity "/roots/swirl/drag", o
      end
    end
    if (o=opts[:alive])
      unity "/roots/alive", o
    end
    if (o=opts[:chase])
      unity "/knitroots/throttle", o

      if (o=opts[:amp])
        unity "/knitroots/amp", o
      end
      if (o=opts[:drag])
        unity "/knitroots/drag", o
      end
      if (o=opts[:force])
        unity "/knitroots/force", o
      end
      if (o=opts[:radius])
        unity "/knitroots/radius", o
      end
      if (o=opts[:target])
        if o == :spiral
        unity "/knitroots/target/spiral", 1.0
        elsif o == :cube
          unity "/knitroots/target/cube", 1.0
        elsif o == :none
          unity "/knitroots/target/none", 1.0
        end
      end
    end

  }
end
def tree(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if o=opts[:height]
    unity "/tree/height",o
  end
  if o=opts[:grow]
    unity "/tree/grow",o
  end
  if o=opts[:circle]
    unity "/tree/circle",o
  end
  if o=opts[:sphere]
    unity "/tree/sphere",o
  end
end
def rocksinit()
  world time: 1.0
  unity "/rocks/vortex", 1.0
  unity "/rocks/vortex/force",-1000.0
  unity "/rocks/turb",0.0
  unity "/rocks/vortex/radius",100.0
  unity "/rocks/pos",6.0
  rocks throttle: 0.0, orbit: 0.0, rot: -100, noise: 10.8
end
def rocks(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if o=opts[:throttle]
    unity "/rockcircle/throttle",o
  end
  if o=opts[:orbit]
    unity "/rockcircle/orbit",o
  end
  if o=opts[:noise]
    unity "/rockcircle/noise",o
  end
  if o=opts[:rot]
    unity "/rockcircle/rot",o
  end
  if o=opts[:rotate]
    unity "/rockcircle/rot",o
  end
  if o=opts[:speed]
    unity "/rockcircle/rotate/speed", o
  end
  if o=opts[:freq]
    unity "/rockcircle/freq",o
  end
  if o=opts[:y]
    unity "/rockcircle/y",o
  end

end
def vortex(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if o=opts[:throttle]
    unity "/rocks/throttle", o
  end
  if opts[:turb]
    unity "/rocks/turb", opts[:turb]
  end
  if o=opts[:force]
    if o == 0.0
      unity "/rocks/vortex",0.0
      unity "/rocks/vortex/force",0.0
    else
      unity "/rocks/vortex",1.0
      unity "/rocks/vortex/force",o
      unity "/rocks/vortex/radius",5.0
    end
  end
  if opts[:y]
    unity "/rocks/pos", opts[:y]
  end
  if opts[:radius]
    unity "/rocks/vortex/radius", opts[:radius]
  end
end

def zoomout
  unity "/cubecam/zoomout", 0.0
  unity "/cubecam/zoomout", 1.0
  at{
    burst 1.0
    unity "/cube/hit", 1.0
    sleep 4.0
    8.times{|n|
      sleep 0.5
      unity "/cube/hit", (8-n)*0.1
      burst (8-n)*0.1
      }
  }
  $pmode=4
end
def cam(type=:main, f=false)
  if type == :exit
    $active_camera=:exit
    if $pmode !=1 || f
      $pmode=1
      unity "/cubecam/zoomout", 0.0
      unity "/cubecam/zoomout", 1.0
      unity "/cubeinside", 0.25*3
      unity "/sea/waveheight", 0.0
      unity "/star/life", 2.0
      at{
        8.times{|n|
          roots throttle: 1.0* (1.0/(n + 1.0))
          sleep 1/2.0
        }
        roots throttle: 0.0
        create_aura
        cube aura: 1.47
      }
    end
  elsif type == :main
    $active_camera=:main
    $pmode=1
    tree height: 1.0
    unity "/cam0"
    unity "/cubeinside", 0.25*3
    unity "/sea/waveheight", 0.0
    unity "/star/life", 2.0
    vortex throttle: 0.01
    create_light
    create_aura
    burst 0.0
    shard 0.0
    roots throttle: 0.0, freq: 0.1, target: :bird, drag: 1.0
    roots chase: 0.1, force: 1, target: :spiral, drag: 3
  elsif type == :top
    $active_camera=:top
    $pmode=2
    create_sea
    unity "/performance",1.0
    rocks orbit: 1
    roots alive: 1
    roots_chase throttle: 0.0
    #only on with lower resolutions
    unity "/cam1"
    end1
    rocks orbit: 0
    unity "/end/shards/throttle",1.0
    at{
      sleep 12
      create_sea -1
      }
    roots swirl: 0.0, throttle: 0
    colorb 0.9
    unity "/lights/end", 0
    #at{
      #sleep 8
      #unity "/eyelids",1.0
    #}

    #performance panics
    unity "/eyelids",0
    vortex throttle: 0.0
    create_aura -2
    unity "/cube",0.0

  elsif type == :bird
    $active_camera=:bird
    $pmode=3
    rocks orbit: 20.0
    world time: 0.1
    unity "/cam2"
  elsif type == :cube
    $active_camera=:cube
    $pmode=0
    unity "/cubecam/zoomin", 0.0
    unity "/cubecam/zoomin", 1.0
    unity "/cubeinside", -0.25
    create_light 0
    create_aura -5
    unity "/cam4"
  elsif type == :chase
    if $active_camera != :chase && $active_camera != :top
      $active_camera=:chase
      unity "/lights/up",0.0
      roots throttle: 0.0
      cube aura: 1.47
      unity "/cube/aura/fresnel", 1.5
      roots_chase throttle: 1.0, drag: 5, amp: 0.026, force: 5, thick: 0.1
      vortex y: 1.25, throttle: 0.2, turb: 0, force: 0
      burst 0
      rocks orbit: 0
      unity "/cube/hit",1
      at{
        sleep 1
        8.times{|n|
          world time: (0.1/8) * n+1
          unity "/cube/hit", (1/8.0)*(8-n)
          sleep 0.125
        }
        unity "/cube/aura/scalemul", 0.0
        unity "/cube/aura/wave", 1.0
        unity "/cube/aura/globalscale", 1
        #may ring?
        #roots_chase target: :ring
        roots_chase target: :cube
      }
      aura fresnel: 1.5, wave: 1.5
      create_aura
    end
  end
end
def defaultcolor
  unity "/linecolor/h",0.0
  unity "/linecolor/s",0.0
  unity "/linecolor/b",0.0

  unity "/color1/b",118/255.0
  unity "/color2/b",255/255.0
  unity "/color3/b",49/255.0

  unity "/color2/h", (328.0 / 360)
  unity "/color1/h",0.0
  unity "/color3/h",0.0
  unity "/color2/s", 1.0
  unity "/color1/s",0.0
  unity "/color3/s",0.0
  unity "/color3/b",0.0
end
def colorb(f=0.0,force=false)
  if f==1.0 && !force
    unity "/color1/b",118/255.0
    unity "/color2/b",255/255.0
    unity "/color3/b",49/255.0
  else
    unity "/color1/b",f
    unity "/color2/b",f
    unity "/color3/b",f
  end
end
def linecolor(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if (f=opts[:cube])
    at{
      sleep 0.5 if opts[:delay] == true
      unity "/linecolor/cube/s",opts[:s] || 0.0
      unity "/linecolor/cube/b",opts[:b] || 1.0+rand*f
      unity "/linecolor/cube/h",opts[:h] || 1.0
      }
  else
    factor = opts[:factor] || 1.0
    at{
      sleep 0.5 if opts[:delay] == true
      unity "/linecolor/s",1.0
      unity "/linecolor/b",1.0
      unity "/linecolor/h",rand*factor
    }
  end
end
def linear_map(x0, x1, y0, y1, x)
  dydx = (y1 - y0) / (x1- x0)
  dx = (x- x0)
  (y0 + (dydx * dx))
end
def color(factor=1)
  if factor
    factor = note(factor)
    factor = linear_map(30, 60, 0.0,1.0, factor)
    at{
    sleep 0.5
    unity "/color3/b",1.0
    unity "/color2/s", 1.0
    unity "/color1/s",1.0
    unity "/color3/s",1.0
    unity "/color2/h", rand*factor
    unity "/color1/h", rand*factor
    unity "/color3/h", rand*factor
    }
  end
end

def colort(f)
  unity "/camtop/color1/b", 1.0*f
end

def cube(*args)
  opts = resolve_synth_opts_hash_or_array(args)
  if (o=opts[:wires])
    unity "/cube/wires/throttle", o
  end
  if (o=opts[:embers])
    unity "/cube/embers/throttle", o
  end
  if (o=opts[:lightning])
    if o > 0
      unity "/cube/lightning/1", o
    else
      unity "/cube/lightning", o
    end
  end
  if (o=opts[:aura])
    unity "/cube/aura/ripple", o
  end
  if (o=opts[:circle])
    unity "/cube/aura/circle", o
  end
  if (o=opts[:rot])
    unity "/cube/rotate/speed", o
  end
end

def aura(opts)
  if (o=opts[:ripple])
    unity "/cube/aura/ripple", o
  end
  if (o=opts[:scale])
    unity "/cube/aura/scalemul", o
  end
  if (o=opts[:fresnel])
    unity "/cube/aura/fresnel", o
  end
  if (o=opts[:distort])
    unity "/cube/aura/globalscale", o
  end
  if (o=opts[:wave])
    unity "/cube/aura/waveheight", o
  end
  if (o=opts[:ping])
    unity "/cube/aura/globalscale", rand*o
  end
end

def roots_init()
  roots chase: 0.0, force: 18.87, radius: 0.01
end

def sea_ball_init
  sea circle: 1, sphere: 1 #ball
  create_sea 0.1 #small
end

def livecode(thing)
  case thing
  when :begin
    at{
      unity "/cam0/glitch_a", 0.1
      unity "/say/begin",1.0
      sleep 4
      unity "/cam0/glitch_v", 0.0
      unity "/say/none",1.0
      unity "/cam0/glitch_a", 0.0
    }
  when :end
    unity "/say/end",1.0
    unity "/attune/flow", 6.0
    n=1.0
    unity "/fadeout",-4.0
    at{
      end2
      sleep 8
    }
  when :rescue
    at{
      unity "/say/rescue",1.0
      sleep 4
      unity "/say/none",1.0

      }
  when :raise
    at{
      unity "/say/raise",1.0
      sleep 4
      unity "/say/none",1.0

      }
  when :sleep
    at{
      unity "/say/sleep",1.0
      sleep 4
      unity "/say/none",1.0

      }

  when :beauty
    unity "/say/beauty"
  when :b
    unity "/say/beauty"
  when :practicality
    unity "/say/practicality"
  when :p
    unity "/say/practicality"
  when :n, :none
    unity "/say/none"
  end
end

def init(force=false)
  if force || $pmode !=0 #only init once
    $active_camera=:main
    $pmode=0
    $chase=false
    start_init
    $xslices=0.0
    $yslices=0.0
    $zslices=0.0
    $cslices=0.0
    $triggered = false
    $end = false
    scene 1
    sleep 2
    world :time, 1.0
    $zslices=0.0
    defaultcolor
    create_tree -1
    create_sea -1
    create_island -1
    create_light 1
    create_light 0
    create_bird -1
    create_cube -2
    create_aura -5
    unity "/cubeinside", -0.25
    roots throttle: 0.0
    rocksinit
    rocks throttle: 1
    vortex y: 1.25, throttle: 0.0, turb: 0, force: 0
    #cube aura: 1.47
    cube rot: 1
    cam :cube
    roots_init
    fx reverb: 1.00, tube: 0.60
    flop_cc motion: 0.30,  drive: 0.00, skip: true
    flip_cc motion: 0.50, drive: 0.00, skip: true
    glitch_cc tubes: 0.50, corode: 0.30
    roots swirl: 0.0, drag: 6.0, freq: 0.0, amp: 0.1
    unity "/cube/hit", 0.0
    star throttle: 0.0
    star size: 0.0000001, life: -100.000001
    cube aura: 1.47

    unity "/lights/up",1.0
    sleep 0.5
    unity "/lights/up",0.0
    unity "/lights/end",0.0

    colorb 0
    unity "/cube/aura/scalemul", -0.6
    create_aura -0.1
    aura fresnel: 1.5, scale: 0.0, wave: 0.01, distort: 1.0
    unity "/fadeout",1.0
    unity "/endshard/throttle",0.0
    at{
      sleep 0.5
      rocks speed: 0.01, orbit: -1.0
    }
    unity "/attune/flow", 1.0
    vortex throttle: 0
    unity "/endroots/circle/speed",30.0
    unity "/endroots/circle/radius",10.0
    unity "/attune/noise",1.5
  end
end

def error(*args)
  opts = resolve_synth_opts_hash_or_array(args)

  if o=opts[:speed]
    unity "/endroots/circle/speed",o
  end
  if o=opts[:radius]
    unity "/endroots/circle/radius",o
  end

  if opts[:target] == :circle
    unity "/endroots/target/circle",1.0
  elsif opts[:target]
    x = (["lt","rb","rt","lb"]-[@error_target])
    @error_target = x.choose
    unity "/endroots/target/#{x}",1
  end
end

def fadeout_roots()
  unity "/fadeoutroots",1.0
  unity "/attune/flow", 1.0
end
