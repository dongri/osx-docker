exports.index = function(req, res){
  res.render('index', {
    title: "hoge",
    message: "Hello World"
  });
};
