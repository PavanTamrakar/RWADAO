// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RWAContract {
    struct Proposal {
        string title;
        string description;
        uint256 votesInFavor;
        uint256 votesAgainst;
        bool isExecuted;
    }

    struct RWA {
        string name;
        address[] members;
        Proposal[] proposals;
    }

    mapping(address => RWA) private rwas;

    event RWAAdded(address indexed rwaAddress, string name);
    event MemberAdded(address indexed rwaAddress, address member);
    event MemberRemoved(address indexed rwaAddress, address member);
    event Vote(address indexed rwaAddress, uint256 indexed proposalIndex, address member, bool inFavor);
    event ProposalCreated(address indexed rwaAddress, uint256 indexed proposalIndex, string title);

    function createRWA(string memory _name, address[] memory _initialMembers) public {
        RWA storage rwa = rwas[msg.sender];
        rwa.name = _name;
        rwa.members = _initialMembers;
        emit RWAAdded(msg.sender, _name);
    }

    function addMember(address _rwaAddress, address _newMember) public {
        RWA storage rwa = rwas[_rwaAddress];
        require(msg.sender == _rwaAddress, "Only the RWA owner can add members");
        rwa.members.push(_newMember);
        emit MemberAdded(_rwaAddress, _newMember);
    }

    function removeMember(address _rwaAddress, address _memberToRemove) public {
        RWA storage rwa = rwas[_rwaAddress];
        require(msg.sender == _rwaAddress, "Only the RWA owner can remove members");

        uint256 indexToRemove = type(uint256).max;
        for (uint256 i = 0; i < rwa.members.length; i++) {
            if (rwa.members[i] == _memberToRemove) {
                indexToRemove = i;
                break;
            }
        }

        require(indexToRemove != type(uint256).max, "Member not found");
        
        rwa.members[indexToRemove] = rwa.members[rwa.members.length - 1];
        rwa.members.pop();
        emit MemberRemoved(_rwaAddress, _memberToRemove);
    }

    function vote(address _rwaAddress, uint256 _proposalIndex, bool _inFavor) public {
        RWA storage rwa = rwas[_rwaAddress];
        require(_proposalIndex < rwa.proposals.length, "Invalid proposal index");
        
        Proposal storage proposal = rwa.proposals[_proposalIndex];
        require(!proposal.isExecuted, "Proposal already executed");

        if (_inFavor) {
            proposal.votesInFavor++;
        } else {
            proposal.votesAgainst++;
        }

        emit Vote(_rwaAddress, _proposalIndex, msg.sender, _inFavor);
    }

    function createProposal(address _rwaAddress, string memory _title, string memory _description) public {
        RWA storage rwa = rwas[_rwaAddress];
        require(msg.sender == _rwaAddress, "Only the RWA owner can create proposals");
        
        Proposal memory newProposal = Proposal({
            title: _title,
            description: _description,
            votesInFavor: 0,
            votesAgainst: 0,
            isExecuted: false
        });
        
        rwa.proposals.push(newProposal);
        emit ProposalCreated(_rwaAddress, rwa.proposals.length - 1, _title);
    }

    function getRWAName(address _rwaAddress) public view returns (string memory) {
        return rwas[_rwaAddress].name;
    }

    function getRWAProposalCount(address _rwaAddress) public view returns (uint256) {
        return rwas[_rwaAddress].proposals.length;
    }

    function getRWAProposal(address _rwaAddress, uint256 _proposalIndex) public view returns (string memory, string memory, uint256, uint256, bool) {
        Proposal storage proposal = rwas[_rwaAddress].proposals[_proposalIndex];
        return (
            proposal.title,
            proposal.description,
            proposal.votesInFavor,
            proposal.votesAgainst,
            proposal.isExecuted
        );
    }

    function getRWAMembers(address _rwaAddress) public view returns (address[] memory) {
        return rwas[_rwaAddress].members;
    }
}