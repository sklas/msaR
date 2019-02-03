HTMLWidgets.widget({

  name: 'msaR',

  type: 'output',
  
  factory: function(el, width, height) {
    
    // define the object at the root node
    
    return {
          renderValue: function(x) {
              
              // msa is initialized with a DOM element, seqs, config, viz, and zoomer
              // https://github.com/wilzbach/msa/blob/master/src/msa.js
              var opts  = x.config;
              var parse = require("biojs-io-fasta").parse;
              opts.el   = el;
              opts.seqs = parse(x.alignment);
    
              var m = msa(opts);

              // init msa
              if (x.menu) {
                // the menu is independent to the MSA container
                var menuOpts = {};
                menuOpts.el = document.getElementById('div');
                menuOpts.msa = m;
                menuOpts.menu = "small";
                var defMenu = new msa.menu.defaultmenu(menuOpts);
                m.addView("menu", defMenu);
              }

              // save msa instance to window object so it can be hacked using shinyjs
              if (x.features) {
                var features = {
                  config: {
                    type: "gff3"
                  },
                  seqs: {}
                };
        
                for(var i=0; i<x.features.length; i++){
                  if(features.seqs[x.features[i].seqName] === undefined || features.seqs[x.features[i].seqName] === null){
                    features.seqs[x.features[i].seqName] = [];
                  }
                  features.seqs[x.features[i].seqName].push({
                    attributes: {
                      Color: "#4285f4",
                      Name: "sgRNA"
                    },
                    end: x.features[i].end,
                    feature: "gene",
                    start: x.features[i].start
                  });
                }
        
                m.seqs.addFeatures(features);
              }
        
              // call render at the end to display the whole MSA
              m.render();
            },

    resize: function(width, height) {
      
      }
    }
  }
});
