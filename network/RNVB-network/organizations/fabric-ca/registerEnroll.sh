

function createOrg1 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/peerOrganizations/governo.federal.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/governo.federal.com/
#  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
#  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-org1 --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/peerOrganizations/governo.federal.com/msp/config.yaml

  echo
	echo "Register peer0"
  echo
  set -x
	fabric-ca-client register --caname ca-org1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  echo
  echo "Register user"
  echo
  set -x
  fabric-ca-client register --caname ca-org1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  echo
  echo "Register the org admin"
  echo
  set -x
  fabric-ca-client register --caname ca-org1 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

	mkdir -p organizations/peerOrganizations/governo.federal.com/peers
  mkdir -p organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com

  echo
  echo "## Generate the peer0 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/msp --csr.hosts peer0.governo.federal.com --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls --enrollment.profile tls --csr.hosts peer0.governo.federal.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/governo.federal.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/governo.federal.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/governo.federal.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/governo.federal.com/tlsca/tlsca.governo.federal.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/governo.federal.com/ca
  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/peers/peer0.governo.federal.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/governo.federal.com/ca/ca.governo.federal.com-cert.pem

  mkdir -p organizations/peerOrganizations/governo.federal.com/users
  mkdir -p organizations/peerOrganizations/governo.federal.com/users/User1@governo.federal.com

  echo
  echo "## Generate the user msp"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/governo.federal.com/users/User1@governo.federal.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  mkdir -p organizations/peerOrganizations/governo.federal.com/users/Admin@governo.federal.com

  echo
  echo "## Generate the org admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/governo.federal.com/users/Admin@governo.federal.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/governo.federal.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/governo.federal.com/users/Admin@governo.federal.com/msp/config.yaml

}


function createOrg2 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/peerOrganizations/sus.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/sus.com/
#  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
#  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-org2 --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/peerOrganizations/sus.com/msp/config.yaml

  echo
	echo "Register peer0"
  echo
  set -x
	fabric-ca-client register --caname ca-org2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  echo
  echo "Register user"
  echo
  set -x
  fabric-ca-client register --caname ca-org2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  echo
  echo "Register the org admin"
  echo
  set -x
  fabric-ca-client register --caname ca-org2 --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

	mkdir -p organizations/peerOrganizations/sus.com/peers
  mkdir -p organizations/peerOrganizations/sus.com/peers/peer0.sus.com

  echo
  echo "## Generate the peer0 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/msp --csr.hosts peer0.sus.com --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/sus.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls --enrollment.profile tls --csr.hosts peer0.sus.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x


  cp ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/sus.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/sus.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/sus.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/sus.com/tlsca/tlsca.sus.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/sus.com/ca
  cp ${PWD}/organizations/peerOrganizations/sus.com/peers/peer0.sus.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/sus.com/ca/ca.sus.com-cert.pem

  mkdir -p organizations/peerOrganizations/sus.com/users
  mkdir -p organizations/peerOrganizations/sus.com/users/User1@sus.com

  echo
  echo "## Generate the user msp"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/sus.com/users/User1@sus.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  mkdir -p organizations/peerOrganizations/sus.com/users/Admin@sus.com

  echo
  echo "## Generate the org admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/sus.com/users/Admin@sus.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  cp ${PWD}/organizations/peerOrganizations/sus.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/sus.com/users/Admin@sus.com/msp/config.yaml

}

function createOrderer {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/ordererOrganizations/rnvb.com

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/rnvb.com
#  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
#  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/ordererOrganizations/rnvb.com/msp/config.yaml


  echo
	echo "Register orderer"
  echo
  set -x
	fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
    set +x

  echo
  echo "Register the orderer admin"
  echo
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

	mkdir -p organizations/ordererOrganizations/rnvb.com/orderers
  mkdir -p organizations/ordererOrganizations/rnvb.com/orderers/rnvb.com

  mkdir -p organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com

  echo
  echo "## Generate the orderer msp"
  echo
  set -x
	fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/msp --csr.hosts orderer.rnvb.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/rnvb.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls --enrollment.profile tls --csr.hosts orderer.rnvb.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/server.key

  mkdir ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/msp/tlscacerts/tlsca.rnvb.com-cert.pem

  mkdir ${PWD}/organizations/ordererOrganizations/rnvb.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/rnvb.com/orderers/orderer.rnvb.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/rnvb.com/msp/tlscacerts/tlsca.rnvb.com-cert.pem

  mkdir -p organizations/ordererOrganizations/rnvb.com/users
  mkdir -p organizations/ordererOrganizations/rnvb.com/users/Admin@rnvb.com

  echo
  echo "## Generate the admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/rnvb.com/users/Admin@rnvb.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${PWD}/organizations/ordererOrganizations/rnvb.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/rnvb.com/users/Admin@rnvb.com/msp/config.yaml


}
