-- Anti-trucks mission with random events for DCS.
-- Created by Diego Silva Prado

function runDice ()
    local dice = 0.0
    for i=1,10 do
        dice = math.random()
    end
    return dice
end

-- Config  --
currentMap = env.mission.theatre

-- Quantidade de inimigos min/max
nIgla = {0,10}
nAK= {0,0}
nFlak = {5,15}
nAAA = {5,15}

runDice()
eNum = {math.random(nIgla[1],nIgla[2]),math.random(nAK[1],nAK[2]),math.random(nFlak[1],nFlak[2]),math.random(nAAA[1],nAAA[2])}

-- Listas de inimigos e Zonas
eGroups={"E_Igla","E_AK","E_FLAK","E_AAA"}
eZones={"AO1","AO2","AO3","AO4","AO5"}

-- Lista de Aeronaves
-- Dummy -- Low -- Medium -- High
cPlanes = {
    ["F-15C"] = {0.0,1.0,2.0,1.0},
    ["Su-27"] = {0.0,1.0,2.0,1.0},
    ["MiG-29S"] = {0.0,1.0,2.0,1.0},
    ["FA-18C_hornet"] = {0.0,1.0,2.0,1.0},
    ["F-14B"] = {1.0,2.0,1.0,0.0},
    ["F-5E-3"] = {2.0,1.0,0.0,0.0},
    ["Ka-50"] = {0.0,2.0,0.0,0.0},
    ["Mi-8MT"] = {0.0,0.5,0.0,0.0},
    ["UH-1H"] = {0.0,0.5,0.0,0.0}
}

--------------------------------------------------------------------------------------
-- Chance of Calling FS - Dummy
figtherSweepDummyInitial = 0.
figtherSweepDummy = 0.
figtherSweepDummyInterval = 30.
figtherSweepDummyIncrease = 0.0
figtherSweepDummyLimit = 0.0
-- Per Player
figtherSweepDummyIncreasePP = 0.02
figtherSweepDummyLimitPP = 1.5

-- Chance of Calling FS - Low
figtherSweepLowInitial = 0.
figtherSweepLow = 0.
figtherSweepLowInterval = 30.
figtherSweepLowIncrease = 0.0
figtherSweepLowLimit = 0.0
-- Per Player
figtherSweepLowIncreasePP = 0.02
figtherSweepLowLimitPP = 1.5

-- Chance of Calling FS - Medium
figtherSweepMediumInitial = 0.
figtherSweepMedium = 0.
figtherSweepMediumInterval = 30.
figtherSweepMediumIncrease = 0.0
figtherSweepMediumLimit = 0.0
-- Per Player
figtherSweepMediumIncreasePP = 0.02
figtherSweepMediumLimitPP = 1.5

-- Chance of Calling FS - High
figtherSweepHighInitial = 0.
figtherSweepHigh = 0.
figtherSweepHighInterval = 30.
figtherSweepHighIncrease = 0.0
figtherSweepHighLimit = 0.0
-- Per Player
figtherSweepHighIncreasePP = 0.02
figtherSweepHighLimitPP = 1.5
---------------------------------------------------------------------------------------

-- Casual Events
casualEventsInterval = 30.
activeEV = false

-- CAS
CASChanceInitial = 0.
CASChanceIncrease = 0.01
CASChanceLimit = 0.75
CASChance = 0.
earlyCASHelp = 300.
middleCASHelp = 600.
deadCASEnd = 900.
intermitencyMsgCAS = 30.

-- Helis
HelisChanceInitial = 0.
HelisChanceIncrease = 0.01
HelisChanceLimit = 0.75
HelisChance = 0.
assemblySAM = 600.

-- Spy
SpyChanceInitial = 0.
SpyChanceIncrease = 0.01
SpyChanceLimit = 0.75
SpyChance = 0.
timeLitmitSpy = 900.

-- Bullseye Position
bePos = mist.utils.makeVec3(mist.DBs.missionData.bullseye.blue)

-- Hyperbolic Function
function increaseTan(t)
    return 0.1*math.tan(t/350.)
end

-- Figther Sweeep Calling
function eFSDummy ()
    runDice()
    local sorteEFS = mist.random(10000)/100.
    if figtherSweepDummy > sorteEFS then
        AARoute = mist.getGroupRoute("E_FS_Dummy")
        FSGroup = mist.cloneGroup("E_FS_Dummy",true)
        mist.goRoute(FSGroup,AARoute)
        figtherSweepDummy = figtherSweepDummyInitial
    else
        if figtherSweepDummy < figtherSweepDummyLimit then
            figtherSweepDummy = figtherSweepDummy + figtherSweepDummyIncrease
        else 
            figtherSweepDummy = figtherSweepDummyLimit
        end
    end
end

function eFSLow ()
    runDice()
    local sorteEFS = mist.random(10000)/100.
    if figtherSweepLow > sorteEFS then
        AARoute = mist.getGroupRoute("E_FS_Low")
        FSGroup = mist.cloneGroup("E_FS_Low",true)
        mist.goRoute(FSGroup,AARoute)
        figtherSweepLow = figtherSweepLowInitial
    else
        if figtherSweepLow < figtherSweepLowLimit then
            figtherSweepLow = figtherSweepLow + figtherSweepLowIncrease
        else 
            figtherSweepLow = figtherSweepLowLimit
        end
    end
end

function eFSMedium ()
    runDice()
    local sorteEFS = mist.random(10000)/100.
    if figtherSweepMedium > sorteEFS then
        AARoute = mist.getGroupRoute("E_FS_Medium")
        FSGroup = mist.cloneGroup("E_FS_Medium",true)
        mist.goRoute(FSGroup,AARoute)
        figtherSweepMedium = figtherSweepMediumInitial
    else
        if figtherSweepMedium < figtherSweepMediumLimit then
            figtherSweepMedium = figtherSweepMedium + figtherSweepMediumIncrease
        else 
            figtherSweepMedium = figtherSweepMediumLimit
        end
    end
end

function eFSHigh ()
    runDice()
    local sorteEFS = mist.random(10000)/100.
    local groupNameFS = math.random(1,2)
    local groupNaameList = {"E_FS_High1","E_FS_High2"}
    if figtherSweepHigh > sorteEFS then
        AARoute = mist.getGroupRoute(groupNaameList[groupNameFS])
        FSGroup = mist.cloneGroup(groupNaameList[groupNameFS],true)
        mist.goRoute(FSGroup,AARoute)
        figtherSweepHigh = figtherSweepHighInitial
    else
        if figtherSweepHigh < figtherSweepHighLimit then
            figtherSweepHigh = figtherSweepHigh + figtherSweepHighIncrease
        else 
            figtherSweepHigh = figtherSweepHighLimit
        end
    end
end

----------------------------------------- Random Events -----------------------------------------------
---------------------------------------------- CAS ----------------------------------------------------
-- Activate CAS
function activateCAS ()
    CASMisFri=mist.cloneInZone("casualCAS_Friend",{"Cassual_CAS_1"})
    CASMisFoe=mist.cloneInZone("casualCAS_Foe",{"Cassual_CAS_1"})
    mist.scheduleFunction(positionCAS,{CASMisFri, CASMisFoe},timer.getTime() + 1) 
    initialCASTime = timer.getTime()
    msgCASHelp = mist.scheduleFunction(callingHelpCAS,{initialCASTime},timer.getTime(),intermitencyMsgCAS,timer.getTime()+deadCASEnd)
    msgCASTerminate = mist.scheduleFunction(CASDefead,{},timer.getTime()+deadCASEnd)
    CASev = mist.addEventHandler(resultCAS) 
    activeEV = true        
end

--Positioning Actors
function positionCAS (CASMisFri, CASMisFoe)
    RouteFriend = mist.getGroupRoute("casualCAS_Friend",true) 
    mist.goRoute(CASMisFri.name,RouteFriend)

    refP1 = mist.getAvgPos({"Ref_Fri"})
    refP2 = mist.getAvgPos({"Ref_Foe"})
    diff = mist.vec.sub(refP2,refP1)

    names={}
    for _,v in pairs(CASMisFri.units) do table.insert(names, v.name) end
    pos = mist.getAvgPos(names)
    finalP = mist.vec.add(pos,diff)

    mist.teleportToPoint({point=finalP,gpName=CASMisFoe.name,action="teleport"})
end

-- Requesting Help
function callingHelpCAS (initialCASTime)
    par = {}
    par.units = {CASMisFri.units[1].name}
    par.ref = bePos
    par.alt = 0
    BRA = mist.getBRString(par)

    mens = {}
    currentTime = timer.getTime()
    elapsedTime = currentTime-initialCASTime
    if elapsedTime < earlyCASHelp then
        mens.text = "Atencao! Uma equipe de resgate aliada foi emboscada por blindados inimigos. Suporte Aereo solicitado em BRA " .. BRA
    elseif elapsedTime > earlyCASHelp and elapsedTime < middleCASHelp then
        mens.text = "Estamos acuados e nao temos como reagir. Estao disparando contra nos! Solicitamos suporte aereo em BRA " .. BRA
    elseif elapsedTime > middleCASHelp then
        mens.text = "Estamos sob fogo pesado e nao sei dizer por quanto tempo aguentaremos. Precisamos de ajuda urgente em BRA " .. BRA
    end
    mens.displayTime = 25
    mens.msgFor = {coa = {'blue'}} 
    mens.sound = "Mantis.wav"
    mist.message.add (mens)
end

-- Checa a vida do alvo
function checkingCAS ()
    doa = false
    vida = 0
    grupo = Group.getByName(CASMisFoe.name):getUnits()
    for _,v in pairs(grupo) do vida = vida + v:getLife() end
    if vida < 1.0 then
        doa = true
    end
    return doa
end

-- CAS Derrota
function CASDefead ()
    mens = {}
    mens.text = "Os cadaveres dos soldados jazem amontoados. O inimigo acha bom, pois seus caes estavam famintos."
    mens.displayTime = 30
    mens.msgFor = {coa = {'blue'}} 
    mens.sound = "failure.wav"
    mist.message.add (mens)
    Group.getByName(CASMisFri.name):destroy()
    Group.getByName(CASMisFoe.name):destroy()
    mist.removeEventHandler(CASev)
    mist.removeFunction(msgCASHelp)
    flagEvento = false
end

-- Verifica se esta Morto CAS
function resultCAS (event)
    if event.id == world.event.S_EVENT_DEAD then
        morto = checkingCAS()
        if morto then
            mens = {}
            mens.text = "Os inimigos foram destruidos. Obrigado pelo suporte!! Agora conseguiremos retornar para base. Resgatamos dois pilotos. Eles darao cobertura para voces. "
            mens.displayTime = 25
            mens.msgFor = {coa = {'blue'}} 
            mens.sound = "victory.wav"
            mist.message.add (mens)
            mist.removeEventHandler(CASev)
            mist.removeFunction(msgCASHelp)
            mist.removeFunction(msgCASTerminate)
            Group.getByName(CASMisFri.name):destroy()
            flagEvento = false
        end
    end
end

------------------------------------------------------- END CAS -------------------------------------------------
--------------------------------------------------- SAM Site Helis ----------------------------------------------
function createSAM()
    local mens = {}
    mens.text = "O sitio de SAM foi montado. Seus misseis reluzem ao sol e se erigem, lancando ominosos riscos negros nas aridas areias do deserto."
    mens.displayTime = 30
    mens.msgFor = {coa = {'blue'}} 
    mens.sound = "failure.wav"
    mist.message.add(mens)
    eSamSite = mist.getGroupData("casual_SAM_Site")
    componentesSam = {}
    for i=1,table.getn(eSamSite.units) do table.insert(componentesSam,eSamSite.units[i].unitName) end
    local posModelo2=mist.getAvgPos(componentesSam)
    adjustedinitPointHeliMis = mist.vec.sub(posModelo2,posModelo)
    local finalPoint = mist.utils.makeVec2(mist.vec.add(mist.utils.makeVec3(initPointHeliMis),adjustedinitPointHeliMis))
    eSamSite = adjustPosition(eSamSite,finalPoint)
    eSamSiteActor=mist.dynAdd(eSamSite)
    mist.removeEventHandler(victoryHeli)
    Group.getByName(chopper.name):destroy()
    flagEvento = false

end

function adjustPosition(grupo,point)
    local componentes = {}
    for i=1,table.getn(grupo.units) do table.insert(componentes,grupo.units[i].unitName) end
    local posModelo=mist.getAvgPos(componentes)
    local ajusteVetor = mist.utils.makeVec2(mist.vec.sub(mist.utils.makeVec3(point),posModelo))
    grupo.groupName=nil
    grupo.groupId=nil
    for i=1,table.getn(grupo.units) do 
        grupo.units[i].unitName=nil 
        grupo.units[i].unitId=nil
        grupo.units[i].x=grupo.units[i].x+ajusteVetor.x
        grupo.units[i].y=grupo.units[i].y+ajusteVetor.y
    end
    return grupo
end

-- Verifica se esta Morto Heli
function resultHeli (event)
    if event.id == world.event.S_EVENT_LAND then
        local initNome = event.initiator
        if initNome and initNome:getGroup() then
            if string.find(initNome:getName(), chopper.units[1].name) and mist.utils.get2DDist(initPointHeliMis,mist.getAvgPos({chopper.units[1].name})) < 10.0 then
                local mens = {}
                mens.text = "O helicoptero chegou ao seu terrível destino. Os soldados iniciam o descarregamento e a montagem do equipamento."
                mens.displayTime = 30
                mens.msgFor = {coa = {'blue'}} 
                mens.sound = "Mantis.wav"
                mist.message.add(mens)
                casualHelisSAMAssembling = mist.scheduleFunction(createSAM,{},timer.getTime()+assemblySAM)
                end
        end
    end
end

-- Terminou o Descarregamento
function deadHelis (event)
    if event.id == world.event.S_EVENT_CRASH or event.id == world.event.S_EVENT_EJECTION or event.id == world.event.S_EVENT_PILOT_DEAD or (event.id == world.event.S_EVENT_LAND and mist.utils.get2DDist(initPointHeliMis,mist.getAvgPos({chopper.units[1].name})) > 10.0) then
        local initDead = event.initiator
        if initDead and initDead:getGroup() then
            if string.find(initDead:getName(), chopper.units[1].name)  then
                local mens = {}
                mens.text = "O helicoptero está em chamas. Os pedacos da SAM que ele carregava se confundem com os da tripulacao em um emaranhado indistinguivel. As tropas no lugar onde ele deveria chegar logo se dispersam"
                mens.displayTime = 30
                mens.msgFor = {coa = {'blue'}} 
                mens.sound = "victory.wav"
                mist.message.add (mens)
                if casualHelisSAMAssembling then
                    mist.removeFunction(casualHelisSAMAssembling)
                end
                Group.getByName(eOutpostActor.name):destroy()
                mist.removeEventHandler(victoryHeli)
                mist.removeEventHandler(Heliev)
                flagEvento = false
            end
        end
    end
end

-- Activate Helis
function activateHelis()
    eOutpost = mist.getGroupData("casual_SAM")
    eHeli=mist.getGroupData("casual_SAM_Heli")
    auxMarcadoresCidade = mist.getGroupData("aux_DesertRock")
    cHIZones={"casual_Heli_Init1","casual_Heli_Init2"}
    componentes = {}
    componentesHeli = {}
    componentesCidade={}
    for i=1,table.getn(eOutpost.units) do table.insert(componentes,eOutpost.units[i].unitName) end
    for i=1,table.getn(auxMarcadoresCidade.units) do table.insert(componentesCidade,mist.utils.makeVec2(mist.getAvgPos({auxMarcadoresCidade.units[i].unitName}))) end
    posModelo=mist.getAvgPos(componentes)

    local mens = {}
    mens.text = "Segundo nossos observadores, o inimigo pretende instalar um posto avancado anti-aereo nas proximidades de Desert Rock. Um helicoptero carregado com os componentes da SAM segue rumo a este posto. Destrua o helicoptero antes que a SAM seja montada."
    mens.displayTime = 30
    mens.msgFor = {coa = {'blue'}} 
    mens.sound = "Mantis.wav"
    mist.message.add(mens)
    
    counter = 0
    for i=1,100 do 
        counter = counter + 1
        initPointHeliMis = mist.getRandomPointInZone("Cassual_Heli_1")
        if not mist.pointInPolygon(initPointHeliMis,componentesCidade) then break end
    end
    
    ajusteVetor = mist.utils.makeVec2(mist.vec.sub(mist.utils.makeVec3(initPointHeliMis),posModelo))

    --Ajuste de Grupo
    eOutpost.groupName=nil
    eOutpost.groupId=nil
    for i=1,table.getn(eOutpost.units) do 
        eOutpost.units[i].unitName=nil 
        eOutpost.units[i].unitId=nil
        eOutpost.units[i].x=eOutpost.units[i].x+ajusteVetor.x
        eOutpost.units[i].y=eOutpost.units[i].y+ajusteVetor.y
    end
    
    for i=1,table.getn(eHeli.units) do table.insert(componentesHeli,eHeli.units[i].name) end
    runDice()
    randZone = math.random(1,table.getn(cHIZones))
    initPointHeli = mist.getRandomPointInZone(cHIZones[randZone])
    
    RouteFriend = mist.getGroupRoute("casual_SAM_Heli",true)
    exemplo = mist.getGroupData("casual_SAM_Heli")
    RouteFriend[1].x = initPointHeli.x
    RouteFriend[1].y = initPointHeli.y
    RouteFriend[2].x = initPointHeliMis.x
    RouteFriend[2].y = initPointHeliMis.y
    RouteFriend[2].task.params.tasks[1].params.x=initPointHeliMis.x
    RouteFriend[2].task.params.tasks[1].params.y=initPointHeliMis.y
    
    polychop = {units={[1]={type="Mi-26",x=initPointHeli.x,y= initPointHeli.y,alt= 200,alt_type= "RADIO",skill= "High",payload={chaff= 0,flare= 192,fuel= "9600",gun= 100},}},country=0,category="helicopter",coalition="red",frequency= 127.5,hidden= false,modulation= 0,radioSet= false,startTime= 0,task= "Transport",uncontrolled= false,route=RouteFriend}

    chopper=mist.dynAdd(polychop)
    eOutpostActor=mist.dynAdd(eOutpost)
    Heliev = mist.addEventHandler(resultHeli)
    victoryHeli = mist.addEventHandler(deadHelis)   
end

-------------------------------------------------- END HELIS ----------------------------------------------------
----------------------------------------------------- SPY -------------------------------------------------------

function comandosSpy ()
    comandosGrupos = {"casualSpyComandos1","casualSpyComandos2","casualSpyComandos3","casualSpyComandos4","casualSpyComandos5"}
    for _, v in pairs(comandosGrupos) do FSGroup = mist.cloneGroup(v,true) end
    local mens = {}
    mens.text = "Figuras furtivas, antes unas com as sombras, deslocam-se agilmente, enquanto flashes e sons de disparos quebram o silencio. A base está sob ataque de comandos inimigos."
    mens.displayTime = 30
    mens.msgFor = {coa = {'blue'}} 
    mens.sound = "failure.wav"
    mist.message.add(mens)
    mist.removeEventHandler(victorySpy)
    mist.removeFunction(defeadSpy)
    for i=1, table.getn(eSpyChopperActors) do 
        Group.getByName(eSpyChopperActors[i].name):destroy()
    end
    flagEvento = false
end

function defeadSpy ()
    local mens = {}
    mens.text = "Os helicopteros mapearam nossas posicoes e se foram da mesma forma que surgiram, transmitindo suas preciosas informacoes aos seus mandantes."
    mens.displayTime = 30
    mens.msgFor = {coa = {'blue'}} 
    mens.sound = "Mantis.wav"
    mist.message.add(mens)
    mist.scheduleFunction(comandosSpy,{},timer.getTime()+1)
end

function deadSpy (event)
    if event.id == world.event.S_EVENT_CRASH or event.id == world.event.S_EVENT_EJECTION or event.id == world.event.S_EVENT_PILOT_DEAD then
        local initDead = event.initiator
        if initDead and initDead:getGroup() then
            for i,v in ipairs(eSpyChopperActorsNames) do
                if v == initDead:getName() then
                    if table.getn(eSpyChopperActorsNames)==3 then
                        local mens = {}
                        mens.text = "Menos um, restam dois!"
                        mens.displayTime = 30
                        mens.msgFor = {coa = {'blue'}} 
                        mens.sound = "Mantis.wav"
                        mist.message.add (mens)
                        table.remove(eSpyChopperActorsNames, i)
                    elseif table.getn(eSpyChopperActorsNames)==2 then
                        local mens = {}
                        mens.text = "Mais um para o colo do capeta! Falta um!"
                        mens.displayTime = 30
                        mens.msgFor = {coa = {'blue'}} 
                        mens.sound = "Mantis.wav"
                        mist.message.add (mens)
                        table.remove(eSpyChopperActorsNames, i)
                    elseif table.getn(eSpyChopperActorsNames)==1 then
                        local mens = {}
                        mens.text = "Todos os helicopteros foram abatidos, a missao furtiva deles fracassou."
                        mens.displayTime = 30
                        mens.msgFor = {coa = {'blue'}} 
                        mens.sound = "victory.wav"
                        mist.message.add(mens)
                        table.remove(eSpyChopperActorsNames, i)
                        mist.removeEventHandler(victorySpy)
                        mist.removeFunction(defeadSpy)
                        flagEvento = false
                    end
                end
            end
        end
    end
end


function activateSpy()
    local mens = {}
    mens.text = "Tres estranhos helicopteros foram vistos sobrevoando a base aerea. Suspeita-se que estejam mapeando a area para alguma operacao inimiga. Destruam essas aeronaves."
    mens.displayTime = 30
    mens.msgFor = {coa = {'blue'}} 
    mens.sound = "Mantis.wav"
    mist.message.add(mens)
    
    eSpyChopperActors = {}
    eSpyChopperActorsNames ={}
    chopperPos = {}
    for i = 1,3 do chopperPos[i] = mist.getRandomPointInZone("casual_Spies",6000) end
    for j = 1,3 do 
        --Ajuste de Grupo
        eSpyChopper = mist.getGroupData("casual_Spy")
        eSpyRoute = mist.getGroupRoute("casual_Spy",true)
        eSpyRoute[1].x = chopperPos[j].x
        eSpyRoute[1].y = chopperPos[j].y
        eSpyRoute[1].task.params.tasks[1].params.x = chopperPos[j].x
        eSpyRoute[1].task.params.tasks[1].params.y = chopperPos[j].y
        
        eSpyChopper.groupName=nil
        eSpyChopper.groupId=nil
        for i=1,table.getn(eSpyChopper.units) do 
            eSpyChopper.units[i].unitName=nil 
            eSpyChopper.units[i].unitId=nil
            eSpyChopper.units[i].x=chopperPos[j].x
            eSpyChopper.units[i].y=chopperPos[j].y
            eSpyChopper.route = eSpyRoute
        end
    
        eSpyChopperActors[j] = mist.dynAdd(eSpyChopper)
        table.insert(eSpyChopperActorsNames,eSpyChopperActors[j].units[1].name)
    end
    defeadSpy = mist.scheduleFunction(defeadSpy,{},timer.getTime() + timeLitmitSpy)
    victorySpy = mist.addEventHandler(deadSpy) 
    flagEvento = true  
end
--------------------------------------------------- END SPY -----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- Trying Casual Event
function casualEv ()
    local eventList = {}
    if not flagEvento then
        runDice()
        local sorteCAS = mist.random(10000)/100.
        if CASChance > sorteCAS then 
            table.insert(eventList,activateCAS) flagEvento = true
            CASChance = CASChanceInitial
            HelisChance = HelisChanceInitial
            SpyChance = SpyChanceInitial
            CASChanceLimit = 0.0
        else
            if CASChance < CASChanceLimit then
                CASChance = CASChance + CASChanceIncrease  
            end       
        end
        runDice()
        local sorteHelis = mist.random(10000)/100.
        if HelisChance > sorteHelis then 
            table.insert(eventList,activateHelis) flagEvento = true
            CASChance = CASChanceInitial
            HelisChance = HelisChanceInitial
            SpyChance = SpyChanceInitial
            HelisChanceLimit = 0.0
        else
            if HelisChance < HelisChanceLimit then
                HelisChance = HelisChance + HelisChanceIncrease
            end
        end
        runDice()
        local sorteSpy = mist.random(10000)/100.
        if SpyChance > sorteSpy then 
            table.insert(eventList,activateSpy) flagEvento = true
            CASChance = CASChanceInitial
            HelisChance = HelisChanceInitial
            SpyChance = SpyChanceInitial
            SpyChanceLimit = 0.0
        else
            if SpyChance < SpyChanceLimit then
                SpyChance = SpyChance + SpyChanceIncrease  
            end          
        end
        if flagEvento then eventList[math.random(1,table.getn(eventList))]() end 
    end
end

-- Helicopter Missions
function checkHelipad (event)
    if event.id == world.event.S_EVENT_LAND and event.place ~= nil then
        unidade = event.initiator
        placeHeli = event.place
        local mens = {}
        mens.text = unidade:getTypeName() .. " pousou em " .. placeHeli:getName()
        mens.displayTime = 30
        mens.msgFor = {coa = {'all'}} 
        mens.sound = "Mantis.wav"
        mist.message.add(mens)
    end
end

function updateOdds()
    local increaseDummy = 0.0
    local limitDummy = 0.
    local increaseLow = 0.0
    local limitLow = 0.
    local increaseMedium = 0.0
    local limitMedium = 0.
    local increaseHigh = 0.0
    local limitHigh = 0.
    -- Adjusting Fighter Sweep - Dummy
    for i,j in pairs(playerPool) do
        increaseDummy = increaseDummy + cPlanes[j][1]*figtherSweepDummyIncreasePP
        limitDummy = limitDummy + cPlanes[j][1]*figtherSweepDummyLimitPP
    end
    -- Adjusting Fighter Sweep - Low
    for i,j in pairs(playerPool) do
        increaseLow = increaseLow + cPlanes[j][2]*figtherSweepLowIncreasePP
        limitLow = limitLow + cPlanes[j][2]*figtherSweepLowLimitPP
    end
    -- Adjusting Fighter Sweep - Medium
    for i,j in pairs(playerPool) do
        increaseMedium = increaseMedium + cPlanes[j][3]*figtherSweepMediumIncreasePP
        limitMedium = limitMedium + cPlanes[j][3]*figtherSweepMediumLimitPP
    end
    -- Adjusting Fighter Sweep - High
    for i,j in pairs(playerPool) do
        increaseHigh = increaseHigh + cPlanes[j][4]*figtherSweepHighIncreasePP
        limitHigh = limitHigh + cPlanes[j][4]*figtherSweepHighLimitPP
    end
    -- Adjusting Fighter Sweep - Dummy
    figtherSweepDummyIncrease = increaseDummy
    figtherSweepDummyLimit = limitDummy
    figtherSweepLowIncrease = increaseLow
    figtherSweepLowLimit = limitLow
    figtherSweepMediumIncrease = increaseMedium
    figtherSweepMediumLimit = limitMedium
    figtherSweepHighIncrease = increaseHigh
    figtherSweepHighLimit = limitHigh
    mist.removeFunction(schedulerEFSDummy)
    mist.removeFunction(schedulerEFSLow)
    mist.removeFunction(schedulerEFSMedium)
    mist.removeFunction(schedulerEFSHigh)
    schedulerEFSDummy = mist.scheduleFunction(eFSDummy,{},timer.getTime() + 1,figtherSweepDummyInterval) -- Cacas de FS Dummy
    schedulerEFSLow = mist.scheduleFunction(eFSLow,{},timer.getTime() + 1,figtherSweepLowInterval) -- Cacas de FS Low
    schedulerEFSMedium = mist.scheduleFunction(eFSMedium,{},timer.getTime() + 1,figtherSweepMediumInterval) -- Cacas de FS Medium
    schedulerEFSHigh = mist.scheduleFunction(eFSHigh,{},timer.getTime() + 1,figtherSweepHighInterval) -- Cacas de FS High
    
    local mens = {}
    mens.text = "Ajustado! \nLimite Dummy: " .. figtherSweepDummyLimit .. " Increase: " .. figtherSweepDummyIncrease .. "\nLimite Low: " .. figtherSweepLowLimit .. " Increase: " .. figtherSweepLowIncrease .. "\nLimite Medium: " .. figtherSweepMediumLimit .. " Increase: " .. figtherSweepMediumIncrease .. "\nLimite High: " .. figtherSweepHighLimit .. " Increase: " .. figtherSweepHighIncrease
    mens.displayTime = 30
    mens.msgFor = {coa = {'all'}} 
    mens.sound = "Mantis.wav"
    mist.message.add(mens)

end

-- Player Pool Check
function checkPlayers (event)
    if event.id == world.event.S_EVENT_BIRTH then
        checkID = event.initiator
        if mist.DBs.humansByName[checkID:getName()] then
            if mist.DBs.humansByName[checkID:getName()].skill == "Client" then
                if playerPool[event.initiator:getPlayerName()] == nil then
                    unidade = event.initiator
                    local mens = {}
                    mens.text = unidade:getPlayerName() .. " assumiu o controle de um " .. unidade:getTypeName() .. "\nOs inimigos estao ansiosos para abate-lo e quanto mais frustrado ele ficar, mais realizados eles se sentirao."
                    mens.displayTime = 30
                    mens.msgFor = {coa = {'all'}} 
                    mens.sound = "Mantis.wav"
                    mist.message.add (mens)
                    playerPool[unidade:getPlayerName()] = unidade:getTypeName()
                    updateOdds()
                end
            end
        end
    end

    if event.id == world.event.S_EVENT_PLAYER_LEAVE_UNIT then
        checkID = event.initiator
        if mist.DBs.humansByName[checkID:getName()] then
            if mist.DBs.humansByName[checkID:getName()].skill == "Client" then
                if playerPool[event.initiator:getPlayerName()] ~= nil then
                    unidade = event.initiator
                    local mens = {}
                    mens.text = unidade:getPlayerName() .. " deixou o " .. unidade:getTypeName() .. "\nOs inimigos sentirao saudades desse aciduo fregues."
                    mens.displayTime = 30
                    mens.msgFor = {coa = {'all'}} 
                    mens.sound = "Mantis.wav"
                    mist.message.add (mens)
                    playerPool[unidade:getPlayerName()] = Null
                end
            end
        end
    end
end



------------------------------------------------------------- Main --------------------------------------------------------------------
for i,v in ipairs(eGroups) do for j = 1,eNum[i] do mist.cloneInZone(v,eZones) end end -- Distribuindo os Inimigos
flagEvento = false
playerPool = {}

figtherSweep = figtherSweepInitial -- Prob Inicial

schedulerEFSDummy = mist.scheduleFunction(eFSDummy,{},timer.getTime() + 1,figtherSweepDummyInterval) -- Cacas de FS Dummy
schedulerEFSLow = mist.scheduleFunction(eFSLow,{},timer.getTime() + 1,figtherSweepLowInterval) -- Cacas de FS Low
schedulerEFSMedium = mist.scheduleFunction(eFSMedium,{},timer.getTime() + 1,figtherSweepMediumInterval) -- Cacas de FS Medium
schedulerEFSHigh = mist.scheduleFunction(eFSHigh,{},timer.getTime() + 1,figtherSweepHighInterval) -- Cacas de FS High

mist.scheduleFunction(casualEv,{},timer.getTime() + 5,casualEventsInterval) -- Secondary Missions
checkPl = mist.addEventHandler(checkPlayers) -- PlayerPool