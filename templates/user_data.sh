#!/bin/sh

: > /etc/fck-nat.conf
echo "eni_id=${TERRAFORM_ENI_ID}" >> /etc/fck-nat.conf
echo "eip_id=${TERRAFORM_EIP_ID}" >> /etc/fck-nat.conf
echo "cwagent_enabled=${TERRAFORM_CWAGENT_ENABLED}" >> /etc/fck-nat.conf
echo "nat64_enabled=${TERRAFORM_NAT64_ENABLED}" >> /etc/fck-nat.conf
echo "nat64_ipv4_addr=${TERRAFORM_NAT64_IPV4_ADDR}" >> /etc/fck-nat.conf
echo "nat64_ipv6_addr=${TERRAFORM_NAT64_IPV6_ADDR}" >> /etc/fck-nat.conf
echo "nat64_ipv4_dynamic_pool=${TERRAFORM_NAT64_DYNAMIC_POOL}" >> /etc/fck-nat.conf

service fck-nat restart
