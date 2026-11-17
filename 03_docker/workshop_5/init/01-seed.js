db = db.getSiblingDB('university');
db.students.createIndex({email:1},{unique:true});
db.courses.createIndex({code:1},{unique:true});
db.students.insertMany([{name:'Ana Torres',email:'ana@example.edu',program:'Ingeniería',active:true},{name:'Luis Pérez',email:'luis@example.edu',program:'Sistemas',active:true}]);
db.courses.insertMany([{code:'CC101',name:'Computación en la Nube',topics:['Docker','AWS','Linux']},{code:'DB101',name:'Bases de Datos',topics:['SQL','NoSQL']}]);
db.enrollments.insertOne({studentEmail:'ana@example.edu',courseCode:'CC101',status:'active'});
