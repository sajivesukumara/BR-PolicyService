// Microservice (Go) - Casbin Client
func CheckPermission(user, object, action string) bool {
	conn, _ := grpc.Dial("policy-service:50051")
	client := pb.NewPolicyServiceClient(conn)
	resp, _ := client.CheckPermission(ctx, &pb.CheckRequest{
		Subject: user,
		Object:  object,
		Action:  action,
	})
	return resp.Allowed
}

func main() {
  CheckPermission("admin", "/bikes", "GET")
}
