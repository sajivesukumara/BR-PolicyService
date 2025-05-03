// Policy Service (gRPC example)
package main

import (
	"github.com/casbin/casbin/v2"
	"google.golang.org/grpc"
)

type PolicyServer struct {
	enforcer *casbin.Enforcer
}

func (s *PolicyServer) CheckPermission(ctx context.Context, req *pb.CheckRequest) (*pb.CheckResponse, error) {
	ok, err := s.enforcer.Enforce(req.Subject, req.Object, req.Action)
	return &pb.CheckResponse{Allowed: ok}, err
}

func main() {
	// e, _ := casbin.NewEnforcer("model.conf", "postgresql://user:pass@policy-db:5432/dbname")
	e, _ := casbin.NewEnforcer("model.conf", "policy.csv")
	grpcServer := grpc.NewServer()
	pb.RegisterPolicyServiceServer(grpcServer, &PolicyServer{enforcer: e})
	grpcServer.Serve(lis)
}
