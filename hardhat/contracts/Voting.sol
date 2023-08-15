pragma solidity ^0.8.0;

contract Voting {

    struct Candidate {
        uint256 id;
        string name;
        uint256 numberOfVotes;
    }

    Candidate[] public candidates;
    address public owner;
    mapping(address => bool) public voters;
    address[] public listofvoters;
    uint256 public votingstart;
    uint256 public votingEnd;
    bool public electionStarted;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not authorized to start an election");
        _;
    }

    modifier electionOngoing() {
        require(electionStarted, "No election yet");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function startElection(string[] memory _candidates, uint256 votingDuration) public onlyOwner {
        require(!electionStarted, "Election is currently ongoing");

        delete candidates;
        delete listofvoters;

        for (uint256 i = 0; i < _candidates.length; i++) {
            candidates.push(Candidate({id: i, name: _candidates[i], numberOfVotes: 0}));
        }

        electionStarted = true;
        votingstart = block.timestamp;
        votingEnd = block.timestamp + (votingDuration * 1 minutes);
    }

    function addCandidate(string memory _name) public onlyOwner electionOngoing {
        candidates.push(Candidate({id: candidates.length, name: _name, numberOfVotes: 0}));
    }

    function voterStatus(address _voter) public view electionOngoing returns (bool) {
        return voters[_voter];
    }

    function voteTo(uint256 _id) public electionOngoing {
        require(!voterStatus(msg.sender), "You already voted. You can only vote once.");

        candidates[_id].numberOfVotes++;
        voters[msg.sender] = true;
        listofvoters.push(msg.sender);
    }

    function retrievevotes() public view returns (Candidate[] memory) {
        return candidates;
    }

    function electionTimer() public view electionOngoing returns (uint256) {
        if (block.timestamp >= votingEnd) {
            return 0;
        }

        return votingEnd - block.timestamp;
    }

    function checkElectionPeriod() public returns (bool) {
        if (electionTimer() > 0) {
            return true;
        }

        electionStarted = false;
        return false;
    }

    function resetAllVoterStatus() public onlyOwner {
        for (uint256 i = 0; i < listofvoters.length; i++) {
            voters[listofvoters[i]] = false;
        }
        delete listofvoters;
    }
}
