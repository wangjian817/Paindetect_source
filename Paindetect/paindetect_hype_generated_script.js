//	HYPE.documents["paindetect"]

(function HYPE_DocumentLoader() {
	var resourcesFolderName = "";
	var documentName = "paindetect";
	var documentLoaderFilename = "paindetect_hype_generated_script.js";

	// find the URL for this script's absolute path and set as the resourceFolderName
	try {
		var scripts = document.getElementsByTagName('script');
		for(var i = 0; i < scripts.length; i++) {
			var scriptSrc = scripts[i].src;
			if(scriptSrc != null && scriptSrc.indexOf(documentLoaderFilename) != -1) {
				resourcesFolderName = scriptSrc.substr(0, scriptSrc.lastIndexOf("/"));
				break;
			}
		}
	} catch(err) {	}

	// Legacy support
	if (typeof window.HYPE_DocumentsToLoad == "undefined") {
		window.HYPE_DocumentsToLoad = new Array();
	}
 
	// load HYPE.js if it hasn't been loaded yet
	if(typeof HYPE_108 == "undefined") {
		if(typeof window.HYPE_108_DocumentsToLoad == "undefined") {
			window.HYPE_108_DocumentsToLoad = new Array();
			window.HYPE_108_DocumentsToLoad.push(HYPE_DocumentLoader);

			var headElement = document.getElementsByTagName('head')[0];
			var scriptElement = document.createElement('script');
			scriptElement.type= 'text/javascript';
			scriptElement.src = resourcesFolderName + '/' + 'HYPE.js?hype_version=108';
			headElement.appendChild(scriptElement);
		} else {
			window.HYPE_108_DocumentsToLoad.push(HYPE_DocumentLoader);
		}
		return;
	}
	
	// guard against loading multiple times
	if(HYPE.documents[documentName] != null) {
		return;
	}
	
	var hypeDoc = new HYPE_108();
	
	var attributeTransformerMapping = {b:"i",c:"i",bC:"i",d:"i",aS:"i",M:"i",e:"f",aT:"i",f:"d",N:"i",O:"i",g:"c",aU:"i",P:"i",Q:"i",aV:"i",R:"c",aW:"f",aI:"i",S:"i",T:"i",l:"d",aX:"i",aJ:"i",m:"c",n:"c",aK:"i",X:"i",aZ:"i",aL:"i",Y:"i",A:"c",B:"c",C:"c",D:"c",t:"i",E:"i",G:"c",bA:"c",a:"i",bB:"i"};

var scenes = [{initialValues:{"57":{o:"content-box",h:"paindetect-2-1.png",p:"no-repeat",x:"visible",a:212,q:"100% 100%",b:218,j:"absolute",r:"inline",c:347,z:"26",k:"div",d:347,e:"0.000000"},"29":{G:"#FFFFFF",bB:4,aU:8,c:267,aV:8,r:"inline",bC:4,d:66,e:"0.000000",X:0,t:24,Y:72,Z:"break-word",v:"bold",w:"\u79fb\u52a8\u4e34\u5e8a\u7814\u7a76",j:"absolute",x:"visible",aZ:0,k:"div",y:"preserve",z:"9",aS:8,E:0,aT:8,bA:"#000000",a:56,b:466},"55":{G:"#FFFFFF",bB:4,aU:8,c:224,aV:8,r:"inline",bC:4,d:66,e:"0.000000",X:0,t:24,Y:72,Z:"break-word",v:"bold",w:"\u6709\u6548\u7684\u6570\u636e",j:"absolute",x:"visible",aZ:0,k:"div",y:"preserve",z:"24",aS:8,E:0,aT:8,bA:"#000000",a:312,b:466},"53":{b:660,z:"23",K:"None",c:90,L:"None",d:15,aS:6,M:0,bD:"none",aT:6,N:0,O:0,aU:6,P:0,aV:6,j:"absolute",k:"div",X:3,A:"#A0A0A0",Y:15,B:"#A0A0A0",Z:"break-word",r:"inline",C:"#A0A0A0",s:"'Arial Black',Gadget,Sans-Serif",D:"#A0A0A0",t:13,aA:{type:1,transition:1,sceneSymbol:1},F:"center",v:"bold",G:"#FFFFFF",aP:"pointer",w:"&gt;&gt; NEXT",x:"visible",I:"None",a:336,y:"preserve",J:"None"},"56":{G:"#FFFFFF",bB:4,aU:8,c:109,aV:8,r:"inline",bC:4,d:66,e:"0.000000",X:0,t:24,Y:72,Z:"break-word",v:"bold",w:"\u4fe1\u606f\u5b89\u5168",j:"absolute",x:"visible",aZ:0,k:"div",y:"preserve",z:"25",aS:8,E:0,aT:8,bA:"#000000",a:564,b:466},"51":{o:"content-box",h:"bs.png",x:"visible",a:539,q:"100% 100%",b:270,j:"absolute",r:"inline",c:170,z:"22",k:"div",d:195,e:"0.000000"},"46":{o:"content-box",h:"sj01.png",x:"visible",a:270,q:"100% 100%",b:307,j:"absolute",r:"inline",c:217,z:"10",k:"div",d:256,e:"0.000000"},"44":{o:"content-box",h:"IPsj.png",p:"no-repeat",x:"visible",a:86,q:"100% 100%",b:270,j:"absolute",r:"inline",c:106,z:"6",k:"div",d:179,e:"0.000000"}},timelines:{kTimelineDefaultIdentifier:{framesPerSecond:30,animations:[{f:"2",t:0,d:1.0333333,i:"e",e:"1.000000",r:1,s:"0.000000",o:"57"},{f:"2",t:1.0333333,d:1,i:"e",e:"1.000000",s:"1.000000",o:"57"},{f:"2",t:2.0333333,d:0.9000001,i:"e",e:"0.000000",s:"1.000000",o:"57"},{f:"2",t:2.5333333,d:0.9333334,i:"e",e:"1.000000",r:1,s:"0.000000",o:"44"},{f:"2",t:2.5333333,d:0.9333334,i:"e",e:"1.000000",r:1,s:"0.000000",o:"46"},{f:"2",t:2.5333333,d:0.9333334,i:"e",e:"1.000000",r:1,s:"0.000000",o:"51"},{f:"2",t:2.5333333,d:0.9333334,i:"e",e:"1.000000",r:1,s:"0.000000",o:"29"},{f:"2",t:2.5333333,d:0.9333334,i:"e",e:"1.000000",r:1,s:"0.000000",o:"55"},{f:"2",t:2.5333333,d:0.9333334,i:"e",e:"1.000000",r:1,s:"0.000000",o:"56"},{f:"2",t:2.9333334,d:0.5333333,i:"e",e:"0.000000",s:"0.000000",o:"57"},{f:"2",t:3.4666667,d:2.5333333,i:"e",e:"1.000000",s:"1.000000",o:"44"}],identifier:"kTimelineDefaultIdentifier",name:"Main Timeline",duration:6}},sceneIndex:0,perspective:"600px",oid:"1",onSceneAnimationCompleteAction:{type:1,transition:1,sceneSymbol:1},backgroundColor:"#808080",name:"Untitled Scene"},{initialValues:{"80":{b:416,z:"9",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#5E5F5F",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:140,B:"#A0A0A0",aM:"80_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"80_pressed",D:"#A0A0A0",t:24,E:0,aA:{goToURL:"http://cn.k519.org/126b228788f375b0cf7b898dd17df603/cv/about",type:5,openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"\u5173\u4e8e\u6211\u4eec",bA:"#000000",x:"visible",I:"Solid",a:392,y:"preserve",bB:0},"78":{b:416,z:"7",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#5E5F5F",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:140,B:"#A0A0A0",aM:"78_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"78_pressed",D:"#A0A0A0",t:24,E:0,aA:{goToURL:"http://input",type:5,openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"\u8f93\u5165\u6570\u636e",bA:"#000000",x:"visible",I:"Solid",a:84,y:"preserve",bB:0},"79":{b:416,z:"8",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#5E5F5F",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:140,B:"#A0A0A0",aM:"79_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"79_pressed",D:"#A0A0A0",t:24,E:0,aA:{goToURL:"http://record",type:5,openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"\u6570\u636e\u5206\u6790",bA:"#000000",x:"visible",I:"Solid",a:238,y:"preserve",bB:0},"81":{b:416,z:"10",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#5E5F5F",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:35.3835,B:"#A0A0A0",aM:"81_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"81_pressed",D:"#A0A0A0",t:24,E:0,aA:{goToURL:"http://cn.k519.org/126b228788f375b0cf7b898dd17df603/neuro/zj",type:5,openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"<div><br></div><div>\u795e\u7ecf\u4e91<br></div><div>\u6587\u732e\u9891\u9053</div>",bA:"#000000",x:"visible",I:"Solid",a:546,y:"preserve",bB:0},"64":{o:"content-box",h:"tengtong.png",x:"visible",a:890,q:"100% 100%",b:193,j:"absolute",r:"inline",c:226,z:"6",k:"div",d:164}},timelines:{"80_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"80"}],identifier:"80_hover",name:"80_hover",duration:1},"75_pressed":{framesPerSecond:30,animations:[],identifier:"75_pressed",name:"75_pressed",duration:0},"79_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#625D5D",o:"79"}],identifier:"79_pressed",name:"79_pressed",duration:1},"81_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"81"}],identifier:"81_pressed",name:"81_pressed",duration:1},"74_pressed":{framesPerSecond:30,animations:[],identifier:"74_pressed",name:"74_pressed",duration:0},"78_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"78"}],identifier:"78_pressed",name:"78_pressed",duration:1},"76_pressed":{framesPerSecond:30,animations:[],identifier:"76_pressed",name:"76_pressed",duration:0},"79_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#625D5D",o:"79"}],identifier:"79_hover",name:"79_hover",duration:1},"78_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"78"}],identifier:"78_hover",name:"78_hover",duration:1},kTimelineDefaultIdentifier:{framesPerSecond:30,animations:[{f:"2",t:0,d:0.23333333,i:"a",e:-134,r:1,s:890,o:"64"},{f:"2",t:0.23333333,d:0.30000001,i:"a",e:505,s:-134,o:"64"},{f:"2",t:0.53333336,d:0.36666662,i:"a",e:92,s:505,o:"64"},{f:"2",t:0.89999998,d:0.4666667,i:"a",e:327,s:92,o:"64"},{f:"2",t:1.3666667,d:0.56666672,i:"a",e:281,s:327,o:"64"}],identifier:"kTimelineDefaultIdentifier",name:"Main Timeline",duration:1.9333334},"80_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"80"}],identifier:"80_pressed",name:"80_pressed",duration:1},"81_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"81"}],identifier:"81_hover",name:"81_hover",duration:1},"77_pressed":{framesPerSecond:30,animations:[],identifier:"77_pressed",name:"77_pressed",duration:0}},sceneIndex:1,perspective:"600px",oid:"58",onSceneAnimationCompleteAction:{goToURL:"pdcd.html",type:5,openInNewWindow:false},backgroundColor:"#808080",name:"Untitled Scene 2"}];


	
	var javascripts = [];


	
	var Custom = {};
	var javascriptMapping = {};
	for(var i = 0; i < javascripts.length; i++) {
		try {
			javascriptMapping[javascripts[i].identifier] = javascripts[i].name;
			eval("Custom." + javascripts[i].name + " = " + javascripts[i].source);
		} catch (e) {
			hypeDoc.log(e);
			Custom[javascripts[i].name] = (function () {});
		}
	}
	
	hypeDoc.setAttributeTransformerMapping(attributeTransformerMapping);
	hypeDoc.setScenes(scenes);
	hypeDoc.setJavascriptMapping(javascriptMapping);
	hypeDoc.Custom = Custom;
	hypeDoc.setCurrentSceneIndex(0);
	hypeDoc.setMainContentContainerID("paindetect_hype_container");
	hypeDoc.setResourcesFolderName(resourcesFolderName);
	hypeDoc.setShowHypeBuiltWatermark(1);
	hypeDoc.setShowLoadingPage(false);
	hypeDoc.setDrawSceneBackgrounds(true);
	hypeDoc.setDocumentName(documentName);

	HYPE.documents[documentName] = hypeDoc.API;

	hypeDoc.documentLoad(this.body);
}());

