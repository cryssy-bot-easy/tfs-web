package com.ucpb.tfsweb.utilities

import org.springframework.beans.BeanUtils
import com.ucpb.tfs.application.command.EtsCommand

/**
 */
public class CommandFactory {

    private Map<String,Class<EtsCommand>> commands;

    public CommandFactory(){
        this.commands = new HashMap<String,Class<EtsCommand>>();
    }

    public CommandFactory(Map<String,Class<EtsCommand>> commands){
        this.commands = commands;
    }

    public EtsCommand getCommand(String name) {
        Class<EtsCommand> commandClass = commands.get(name);
        if(commandClass == null){
            return null;
        }
        return (EtsCommand)BeanUtils.instantiate(commandClass);
    }
}
