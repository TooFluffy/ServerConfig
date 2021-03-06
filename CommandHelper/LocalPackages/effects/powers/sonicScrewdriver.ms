bind(player_interact,null,array('button': 'RIGHT'),@event){
    
    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    if(!has_permission(@pname,"powers.sonicscrewdriver")){
        die()
    }
    @item = get_inventory(entity_id(@puuid),pheld_slot(@pname))
    if(@item == null){
        die()
    }
    if(@item['type'] != 76){
        die()
    }
    
    if(is_null(get_value(@pname.'lastSonicScrewdriver')),
        store_value(@pname.'lastSonicScrewdriver',0)
    )
    if(@item['meta'] == null || @item['meta']['display'] == null || @item['meta']['display'] != '§4S§7onic §0S§7crewdr§8i§7ver'){
        die()
    }
    
    assign(@cooldown, 10)
    
    assign(@lastSonicScrewdriver, get_value(@pname.'lastSonicScrewdriver'))
    if(@lastSonicScrewdriver + @cooldown > time() / 1000,
        tmsg(@pname,color(red).'Sonic Screwdriver has a 10 second cooldown!')
        die()
    )
    store_value(@pname.'lastSonicScrewdriver', time() / 1000)
    
    try(
        @face = @event['facing']
        @blockLocation = @event['location']

        if(@face == 'up'){
            @blockLocation[1] = @blockLocation[1] + 1
            set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'0:0',@blockLocation[3])
            set_timeout(50,closure(    
                set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'76:0',@blockLocation[3])
            ))
        }else if(@face == 'north'){
            @blockLocation[2] = @blockLocation[2] - 1
            set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'0:0',@blockLocation[3])
            set_timeout(50,closure(    
                set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'76:4',@blockLocation[3])
            ))
        }else if(@face == 'east'){
            @blockLocation[0] = @blockLocation[0] + 1
            set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'0:0',@blockLocation[3])
            set_timeout(50,closure(    
                set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'76:1',@blockLocation[3])
            ))
        }else if(@face == 'west'){
            @blockLocation[0] = @blockLocation[0] - 1
            set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'0:0',@blockLocation[3])
            set_timeout(50,closure(    
                set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'76:2',@blockLocation[3])
            ))
        }else if(@face == 'south'){
            @blockLocation[2] = @blockLocation[2] + 1
            set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'0:0',@blockLocation[3])
            set_timeout(50,closure(    
                set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'76:3',@blockLocation[3])
            ))
        }

        set_timeout(5000,closure(
            set_block_at(@blockLocation[0],@blockLocation[1],@blockLocation[2],'0:0',@blockLocation[3])
        ))
        cancel()
    ,
    )
}
