pragma solidity ^0.4.24;

contract Registration {
    struct User {
        string name;
        string email;
        string affiliation;
        string attendAs;
        bool agreeToShare;
        bool submitted;
    }

    mapping(address => User) private users;
    address[] private addresses;
    mapping(address => bool) private viewers;
    address private owner = msg.sender;

    constructor() public {
        addViewer(owner);
    }

    function addUser(
        string _name,
        string _email,
        string _affiliation,
        string _attendAs,
        bool _agreeToShare)
        public returns(bool)
    {
        address id = msg.sender;
        if (users[id].submitted) {
            return false;
        }

        users[id] = User(_name, _email, _affiliation, _attendAs, _agreeToShare, true);
        addresses.push(id);
        return true;
    }

    function getUsers() public constant returns(address[]) {
        if (!viewers[msg.sender]) {
            address[] memory emptyArray;
            return emptyArray;
        }
        return addresses;
    }

    function addViewer(address _id) public returns(bool) {
        if (msg.sender != owner) {
            return false;
        }

        viewers[_id] = true;
        return true;
    }

    function removeViewer(address _id) public returns(bool) {
        if (msg.sender != owner) {
            return false;
        }

        delete viewers[_id];
        return true;
    }

}
