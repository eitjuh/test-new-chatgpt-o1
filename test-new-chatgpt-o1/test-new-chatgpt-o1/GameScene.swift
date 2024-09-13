import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird: SKSpriteNode!
    let birdCategory: UInt32 = 1 << 0
    let pipeCategory: UInt32 = 1 << 1

    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        physicsWorld.contactDelegate = self

        backgroundColor = SKColor.cyan
        
        bird = SKSpriteNode(imageNamed: "bird")
        bird.position = CGPoint(x: size.width * 0.3, y: size.height / 2)
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.categoryBitMask = birdCategory
        bird.physicsBody?.collisionBitMask = pipeCategory
        bird.physicsBody?.contactTestBitMask = pipeCategory
        addChild(bird)
        
        let spawn = SKAction.run { [weak self] in
            self?.createPipes()
        }
        let delay = SKAction.wait(forDuration: 2.0)
        let sequence = SKAction.sequence([spawn, delay])
        run(SKAction.repeatForever(sequence))
    }
    
    func createPipes() {
        let pipeTexture = SKTexture(imageNamed: "pipe")
        
        let pipeUp = SKSpriteNode(texture: pipeTexture)
        pipeUp.position = CGPoint(x: size.width + pipeUp.size.width/2, y: size.height / 2 + 100)
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeUp.physicsBody?.isDynamic = false
        pipeUp.physicsBody?.categoryBitMask = pipeCategory
        addChild(pipeUp)
        
        let pipeDown = SKSpriteNode(texture: pipeTexture)
        pipeDown.yScale = -1
        pipeDown.position = CGPoint(x: size.width + pipeDown.size.width/2, y: size.height / 2 - 100)
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size)
        pipeDown.physicsBody?.isDynamic = false
        pipeDown.physicsBody?.categoryBitMask = pipeCategory
        addChild(pipeDown)
        
        let move = SKAction.moveBy(x: -size.width - pipeUp.size.width, y: 0, duration: 4)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        pipeUp.run(sequence)
        pipeDown.run(sequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Handle collision
        self.removeAllChildren()
        // Restart the game or show game over
    }
}