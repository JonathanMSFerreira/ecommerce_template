class ResponseRepository<T>{


  bool ok;
  String msg;
  T result;

  ResponseRepository.ok(this.result){


    ok = true;

  }

  ResponseRepository.error(this.msg){


    ok = false;

  }





}