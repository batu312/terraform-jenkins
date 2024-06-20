resource "aws_lb_target_group" "TG1" {
  name     = "TG1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vm-vpc.id
}

resource "aws_lb_target_group_attachment" "TGA" {
  target_group_arn = aws_lb_target_group.TG1.arn
  target_id        = aws_instance.vm12[0].id
  port             = 80
}
resource "aws_lb" "ALB" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0dbd20cb24388a595"]
  subnets            = ["subnet-0a8379124af2cbd5e", "subnet-07445c4aeef8321a8"]

}

resource "aws_lb_listener" "ALBL" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG1.arn
  }
}