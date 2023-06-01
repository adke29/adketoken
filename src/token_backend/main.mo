import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
actor Token {
  var owner : Principal = Principal.fromText("qoli5-zr26z-ph4pv-mcmnk-hlmru-zyhjw-pphk4-socqs-qx43f-dal7t-mqe");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "ADKE";

  private stable var balanceEntries:[(Principal, Nat)]=[];

  private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  
  public func reset(password: Text):async Text{
    if(password == "qoli5-zr26z-ph4pv-mcmnk-hlmru-zyhjw-pphk4-socqs-qx43f-dal7t-mqe"){
      balances := HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
      balances.put(owner, totalSupply);
      return "Reset Success";
    }else{
      return "Wrong Password";
    }
    
  };

  public query func balanceOf(who : Principal) : async Nat {
    let balance : Nat = switch (balances.get(who)) {
      case null 0;
      case (?result) result;
    };
    return balance;
  };

  public query func getSymbol() : async Text {
    return symbol;
  };

  public shared(msg) func payOut():async Text{
    if(balances.get(msg.caller) == null){
      
        Debug.print(debug_show(msg.caller) # " claimed 1000 ADKE");
        let result = transfer(msg.caller, 1000);
        return "Success";
    }else{
      return "You have claimed before!!";
    }
  };

  public shared(msg) func transfer(to: Principal, amount: Nat):async Text{
    let result:Text = await targetedTransfer(msg.caller,to,amount);
    return result;
  };


  public func targetedTransfer(from: Principal, to:Principal, amount:Nat):async Text{
    Debug.print(debug_show(from) # " is transfering " #debug_show(amount) #" ADKE to " # debug_show(to));
    let fromBalance:Nat = await balanceOf(from);
    if(fromBalance >= amount){
      let toBalance:Nat = await balanceOf(to);
      balances.put(from, fromBalance - amount);
      balances.put(to, toBalance + amount);
      Debug.print("Transfer success");
      return "Success";
    }else{
      Debug.print("Insufficient Balance, transfer failed");
      return "Insufficient Balance";
    }
  };

  system func preupgrade(){
    balanceEntries := Iter.toArray(balances.entries());
  };
  system func postupgrade(){
    balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(),1, Principal.equal, Principal.hash);
    
    if(balances.size() < 1){
      balances.put(owner, totalSupply);
    }
  };
};
