unit.hideWidget();
screenTitle = "Industry Monitoring";
admin = "Timesorrow";
renderScript =
    "local json = require('dkjson')\nlocal input = getInput() \nlocal data = json.decode (input)\nlocal dataReceived = data[1]\nlocal itemKey = data[2]\nlocal tableContents = data[3]\nlocal updateScreen = data[4]\nlocal editor = data[5]\nlocal modal = data[6]\nlocal searchResult = data[8]\nlocal filter = data[7]\nlocal updateScreenModal = data[8]\nlocal updateIndustryStatus = data[9]\nlocal modalPage = data[10] or 0\nlocal totalPages = data[11] or 0\nlocal selectedItem = data[12] or nil\nlocal inputItem = data[15] or 0\nlocal screenTitle = data[16] or ''\nlocal buttons = data[17] or {}\nlocal activePage = data[18] or ''\nlocal machineSelected = data[19] or ''\nlocal currentProduct = data[20] or ''\nlocal commit = data[22] or 0\nlocal newProduct = data[21] or currentProduct\nlocal background = \"assets.prod.novaquark.com/146072/59702fc8-efa6-499a-bd10-3b0abe46a40c.png\"\nif not IndustryStatus then IndustryStatus = {} end\nif not IndustryStatusStored then IndustryStatusStored = {} end\nif itemKey == 1 and dataReceived == 'IndustryStatus' then IndustryStatus = {} end\nlocal i = 0\nlocal j = 0\nfunction getRGBGradient(a,b,c,d,e,f,g,h,i,j)a=-1*math.cos(a*math.pi)/2+0.5;local k=0;local l=0;local m=0;if a>=.5 then a=(a-0.5)*2;k=e-a*(e-h)l=f-a*(f-i)m=g-a*(g-j)else a=a*2;k=b-a*(b-e)l=c-a*(c-f)m=d-a*(d-g)end;return k,l,m end\n\n-- Setup\nindustryStates={'Stopped','Running', 'Missing ingredient', 'Output full', 'No output container' , 'Pending', 'Missing schematics'}\nlocal rx,ry = getResolution()\nlocal bg = createLayer() local fg = createLayer() local ml = createLayer() local tl = createLayer() local colorLayer = createLayer()\nif not modalText then modalText = '' end\nfont_size = 12\nlocal font = loadFont(\"RobotoCondensed\", font_size)\nlocal font2 = loadFont(\"RobotoCondensed\", font_size*1.5)\nlocal font3 = loadFont(\"RobotoCondensed\", font_size*2)\n\n--Convert Data Tables\n\nif tableContents ~= {} and tableContents ~= nil and dataReceived == 'IndustryStatus' then  \n    IndustryStatus[itemKey] = {            \n        itemName=tableContents[1]['itemName'],\n        id=tableContents[1]['id'],\n        state=tableContents[1]['state'],\n        product = tableContents[1]['product'] or 0,\n        unitsProduced = tableContents[1]['unitsProduced'] or 0,\n        remainingTime = tableContents[1]['remainingTime'] or 0,\n        batchesRequested = tableContents[1]['batchesRequested'] or 0,\n        batchesRemaining = tableContents[1]['batchesRemaining'] or 0,\n        maintainProductAmount = tableContents[1]['maintainProductAmount'] or 0,\n        endTimeBatch = tableContents[1]['endTimeBatch'] or 0,\n        endTimeTotal = tableContents[1]['endTimeTotal'] or 0,\n        currentTime = tableContents[1]['currentTime'] or 0,\n        currentProductAmount = tableContents[1]['currentProductAmount'] or 0\n        }\n    if updateIndustryStatus and dataReceived == 'IndustryStatus' then IndustryStatusStored = IndustryStatus end\nend\n\n-- Drawing to screen\naddImage(bg, loadImage(background), rx-282, 0, 262, 71 )\nsetNextFillColor(bg, 22/255, 116/255, 209/255, 0.5)\naddBox(bg,0,71,rx,40)\naddLine(bg,0,71,rx,71)\naddLine(bg,0,111,rx,111)\naddText(bg,font2,activePage,20,100)\nsetNextTextAlign(bg, AlignH_Left, AlignV_Middle)\naddText(bg,font3,screenTitle,20,35)\n\nif #IndustryStatusStored>0 and activePage == 'Industry Status' then\n    i = 1\n    y = 140\n    x = 40    \n    --table.sort(itemsContainerStored, function (left, right) return left['itemName'] < right['itemName'] end )     \n    for k,v in pairs(IndustryStatusStored) do\n        if selectedItem == k then\n                setNextFillColor(fg, 22/255, 116/255, 209/255, 1)\n            else\n                setNextFillColor(fg, 0.5, 0.5, 0.5, 0)\n            end\n        addBox(fg,x-20,y-font_size/2,480,font_size)\n        if v['state'] == 2 then\n            setDefaultFillColor(fg, Shape_Text,0, 1, 0, 1)\n            if string.len(v['endTimeBatch'])>0 then\n                setNextTextAlign(fg,AlignH_Left,AlignV_Middle)\n                addText(fg,font, v['endTimeBatch'], x+350, y)\n            else\n                setNextTextAlign(fg,AlignH_Left,AlignV_Middle)\n                addText(fg,font, 'Unknown', x+350, y)\n            end\n        end\n        if v['state'] == 3 then\n            setDefaultFillColor(fg, Shape_Text,1, 0, 0, 1)\n        end\n        if v['state'] == 7 then\n            setDefaultFillColor(fg, Shape_Text,1, 0, 1, 1)\n        end\n        setNextTextAlign(fg,AlignH_Left,AlignV_Middle)\n        addText(fg,font, tostring(v['itemName']), x, y)\n        setNextTextAlign(fg,AlignH_Left,AlignV_Middle)\n        addText(fg,font, tostring(v['product']), x+175, y)\n \n        setNextTextAlign(fg,AlignH_Left,AlignV_Middle)\n        if v['batchesRemaining'] >0 and v['state'] == 2 then\n            statusText = tostring(industryStates[v['state'] ])..'('.. v['batchesRemaining']..')'\n        else\n            statusText = tostring(industryStates[v['state'] ])\n        end\n        addText(fg,font, statusText, x+400, y) \n        \n        setDefaultFillColor(fg, Shape_Text,1, 1, 1, 1)\n        \n        y = y + font_size\n        if y >600 then\n            y = 140\n            x = x+500\n        end\n    end   \nend\n";
buttons = {};
for slot_name, slot in pairs(unit) do
    if type(slot) == "table" and type(slot.export) == "table" and slot.getClass then
        if (slot.getName()):lower() == "databank industry capabilities" then
            databankcapabilities = slot;
        end
        if (slot.getName()):lower() == "databank inventory" then
            databankinventory = slot;
        end
        if (slot.getName()):lower() == "databank schematics" then
            databank = slot;
        end
        if (slot.getName()):lower() == "databank commands" then
            databankCommands = slot;
        end
        if ((slot.getClass()):lower()):find("coreunit") then
            core = slot;
        end
        if ((slot.getClass()):lower()):find("container") then
            container = slot;
        end
        if ((slot.getClass()):lower()):find("screen") then
            screen = slot;
        end
        if (slot.getClass()):lower() == "emitterunit" then
            emitter = slot;
        end
    end
end
editor = player.getName() == admin;
screen.setRenderScript(renderScript);
i = 0;
if not update then
    update = 1;
end
if not inputItem then
    inputItem = 0;
end
if not schematicsOnScreen then
    schematicsOnScreen = 0;
end
if not content then
    content = {};
end
if not modalPage then
    modalPage = 1;
end
if not modalPageSchematics then
    modalPageSchematics = 1;
end
items_table = {};
search = true;
activePage = "Industry Status";
coroutinesTable = {};
if not modal then
    modal = false;
end
searchTerm = "fuel";
searchResultsOnScreen = 0;
schematicsRequest = {};
industryStatus = {};
update = 1;
sliceSearch = {};
sliceIndustry = {};
machineSelected = "basic assembly line s";
updateContainerPing = true;
updateTransferPing = true;
previousStatus = json.decode(databankCommands.getStringValue("previousStatus")) or {};
MyCoroutines = {function()
    elementsIdList = core.getElementIdList();
    industry_number = 1;
    industryStatus = {};
    system_time = math.floor(system.getArkTime());
    for index, id in ipairs(elementsIdList) do
        elementType = (core.getElementClassById(id)):lower();
        elementTypeName = core.getElementDisplayNameById(id);
        if elementType:find("industry") and (not (elementTypeName:lower()):find("transfer")) then
            status = core.getElementIndustryInfoById(id);
            for k, v in pairs(previousStatus) do
                if v.selectedMachineID == id then
                    if v.state ~= status.state and status.state == 2 or v.batchesRemaining > status.batchesRemaining then
                        endTimeBatch = system.getUtcTime() + status.remainingTime;
                        endTimeTotal = system.getUtcTime() + status.remainingTime * status.batchesRemaining;
                    else
                        endTimeBatch = tonumber(v.endTimeBatch);
                        if endTimeBatch - system.getUtcTime() < 0 then
                            endTimeBatch = endTimeBatch + status.remainingTime;
                        end
                        endTimeTotal = tonumber(v.endTimeTotal);
                    end
                end
            end
            if status.currentProducts[1] ~= nil then
                productName = (system.getItem(status.currentProducts[1].id)).displayNameWithSize;
            else
                productName = "Unassigned";
            end
            if endTimeBatch == nil then
                endTimeBatch = 0;
            end
            if endTimeTotal == nil then
                endTimeTotal = 0;
            end
            table.insert(industryStatus, {
                elementTypeName = core.getElementNameById(id),
                state = status.state,
                endTimeBatch = endTimeBatch,
                batchesRemaining = status.batchesRemaining,
                productName = productName,
                endTimeTotal = endTimeTotal,
                currentTime = system.getUtcTime(),
                selectedMachineID = id
            });
            coroutine.yield(coroutinesTable[1]);
        end
        industry_number = industry_number + 1;
    end
    table.sort(industryStatus, function(left, right)
        return left.elementTypeName < right.elementTypeName;
    end);
    sliceIndustry = table.move(industryStatus, 0 * 72 + 1, 0 * 72 + 72, 1, {});
    for kIn, vIn in pairs(sliceIndustry) do
        coroutine.yield(coroutinesTable[7]);
        tempIn = {};
        if vIn.endTimeBatch - vIn.currentTime > 0 then
            endTimeBatchText = getTimeString(vIn.endTimeBatch - vIn.currentTime);
        else
            endTimeBatchText = "Unknown";
        end
        table.insert(tempIn, {
            itemName = vIn.elementTypeName,
            state = vIn.state,
            product = vIn.productName,
            batchesRequested = vIn.batchesRequested,
            batchesRemaining = vIn.batchesRemaining,
            maintainProductAmount = vIn.maintainProductAmount,
            currentProductAmount = vIn.currentProductAmount,
            unitsProduced = vIn.unitsProduced,
            remainingTime = vIn.remainingTime,
            endTimeBatch = endTimeBatchText,
            endTimeTotal = vIn.endTimeTotal,
            currentTime = vIn.currentTime
        });
        local storage_data = {"IndustryStatus", kIn, tempIn, false, editor, modal, searchTerm, false,
                              kIn == (#sliceIndustry), modalPage, totalPages, selectedItem, modalPageSchematics,
                              totalPagesSchematics, inputItem, screenTitle, buttons, activePage, machineSelected,
                              currentProduct, newProduct, commit};
        local to_send = json.encode(storage_data);
        screen.setScriptInput(to_send);
    end
    previousStatus = industryStatus;
    coroutine.yield(coroutinesTable[1]);
end};
function initCoroutines()
    for _, f in pairs(MyCoroutines) do
        local co = coroutine.create(f);
        table.insert(coroutinesTable, co);
    end
end
initCoroutines();
runCoroutines = function()
    for i, co in ipairs(coroutinesTable) do
        if coroutine.status(co) == "dead" then
            coroutinesTable[i] = coroutine.create(MyCoroutines[i]);
        end
        if coroutine.status(co) == "suspended" then
            assert(coroutine.resume(co));
        end
    end
end;
MainCoroutine = coroutine.create(runCoroutines);
