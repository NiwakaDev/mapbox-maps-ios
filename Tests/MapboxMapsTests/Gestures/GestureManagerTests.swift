import XCTest
@testable import MapboxMaps

final class GestureManagerTests: XCTestCase {

    var mapboxMap: MockMapboxMap!
    var cameraAnimationsManager: MockCameraAnimationsManager!
    var panGestureHandler: MockPanGestureHandler!
    var pinchGestureHandler: MockPinchGestureHandler!
    var rotateGestureHandler: MockRotateGestureHandler!
    var pitchGestureHandler: GestureHandler!
    var doubleTapToZoomInGestureHandler: MockFocusableGestureHandler!
    var doubleTouchToZoomOutGestureHandler: MockFocusableGestureHandler!
    var quickZoomGestureHandler: MockFocusableGestureHandler!
    var singleTapGestureHandler: GestureHandler!
    var anyTouchGestureHandler: GestureHandler!
    var gestureManager: GestureManager!
    // swiftlint:disable:next weak_delegate
    var delegate: MockGestureManagerDelegate!

    override func setUp() {
        super.setUp()
        mapboxMap = MockMapboxMap()
        cameraAnimationsManager = MockCameraAnimationsManager()
        panGestureHandler = MockPanGestureHandler(
            gestureRecognizer: MockGestureRecognizer())
        pinchGestureHandler = MockPinchGestureHandler(
            gestureRecognizer: MockGestureRecognizer())
        rotateGestureHandler = MockRotateGestureHandler(gestureRecognizer: MockGestureRecognizer())
        pitchGestureHandler = makeGestureHandler()
        doubleTapToZoomInGestureHandler = MockFocusableGestureHandler(
            gestureRecognizer: MockGestureRecognizer())
        doubleTouchToZoomOutGestureHandler = MockFocusableGestureHandler(
            gestureRecognizer: MockGestureRecognizer())
        quickZoomGestureHandler = MockFocusableGestureHandler(gestureRecognizer: MockGestureRecognizer())
        singleTapGestureHandler = makeGestureHandler()
        anyTouchGestureHandler = makeGestureHandler()
        gestureManager = GestureManager(
            panGestureHandler: panGestureHandler,
            pinchGestureHandler: pinchGestureHandler,
            rotateGestureHandler: rotateGestureHandler,
            pitchGestureHandler: pitchGestureHandler,
            doubleTapToZoomInGestureHandler: doubleTapToZoomInGestureHandler,
            doubleTouchToZoomOutGestureHandler: doubleTouchToZoomOutGestureHandler,
            quickZoomGestureHandler: quickZoomGestureHandler,
            singleTapGestureHandler: singleTapGestureHandler,
            anyTouchGestureHandler: anyTouchGestureHandler,
            mapboxMap: mapboxMap)
        delegate = MockGestureManagerDelegate()
        gestureManager.delegate = delegate
    }

    override func tearDown() {
        delegate = nil
        gestureManager = nil
        anyTouchGestureHandler = nil
        singleTapGestureHandler = nil
        quickZoomGestureHandler = nil
        doubleTouchToZoomOutGestureHandler = nil
        doubleTapToZoomInGestureHandler = nil
        pitchGestureHandler = nil
        pinchGestureHandler = nil
        panGestureHandler = nil
        cameraAnimationsManager = nil
        mapboxMap = nil
        super.tearDown()
    }

    func makeGestureHandler() -> GestureHandler {
        return GestureHandler(gestureRecognizer: MockGestureRecognizer())
    }

    func testPanGestureRecognizer() {
        XCTAssertTrue(gestureManager.panGestureRecognizer === panGestureHandler.gestureRecognizer)
    }

    func testPinchGestureRecognizer() {
        XCTAssertTrue(gestureManager.pinchGestureRecognizer === pinchGestureHandler.gestureRecognizer)
    }

    func testPitchGestureRecognizer() {
        XCTAssertTrue(gestureManager.pitchGestureRecognizer === pitchGestureHandler.gestureRecognizer)
    }

    func testRotateGestureRecognizer() {
        XCTAssertTrue(gestureManager.rotateGestureRecognizer === rotateGestureHandler.gestureRecognizer)
    }

    func testSingleTapGestureRecognizer() {
        XCTAssertTrue(gestureManager.singleTapGestureRecognizer === singleTapGestureHandler.gestureRecognizer)
    }

    func testDoubleTapToZoomInGestureRecognizer() {
        XCTAssertTrue(gestureManager.doubleTapToZoomInGestureRecognizer
                        === doubleTapToZoomInGestureHandler.gestureRecognizer)
    }

    func testDoubleTouchToZoomOutGestureRecognizer() {
        XCTAssertTrue(gestureManager.doubleTouchToZoomOutGestureRecognizer
                        === doubleTouchToZoomOutGestureHandler.gestureRecognizer)
    }

    func testQuickZoomGestureRecognizer() {
        XCTAssertTrue(gestureManager.quickZoomGestureRecognizer === quickZoomGestureHandler.gestureRecognizer)
    }

    func testAnyTouchGestureRecognizer() {
        XCTAssertTrue(gestureManager.anyTouchGestureRecognizer === anyTouchGestureHandler.gestureRecognizer)
    }

    func testPanGestureHandlerDelegate() {
        XCTAssertTrue(panGestureHandler.delegate === gestureManager)
    }

    func testPinchGestureHandlerDelegate() {
        XCTAssertTrue(pinchGestureHandler.delegate === gestureManager)
    }

    func testRotateGestureHandlerDelegate() {
        XCTAssertTrue(rotateGestureHandler.delegate === gestureManager)
    }

    func testPitchGestureHandlerDelegate() {
        XCTAssertTrue(pitchGestureHandler.delegate === gestureManager)
    }

    func testDoubleTapToZoomInGestureHandlerDelegate() {
        XCTAssertTrue(doubleTapToZoomInGestureHandler.delegate === gestureManager)
    }

    func testDoubleTouchToZoomOutGestureHandlerDelegate() {
        XCTAssertTrue(doubleTouchToZoomOutGestureHandler.delegate === gestureManager)
    }

    func testSingleTapGestureHandlerDelegate() {
        XCTAssertTrue(singleTapGestureHandler.delegate === gestureManager)
    }

    func testQuickZoomGestureHandlerDelegate() {
        XCTAssertTrue(quickZoomGestureHandler.delegate === gestureManager)
    }

    func testPinchGestureRecognizerRequiresPanGestureRecognizerToFail() throws {
        let pinchGestureRecognizer = try XCTUnwrap(pinchGestureHandler.gestureRecognizer as? MockGestureRecognizer)

        XCTAssertEqual(pinchGestureRecognizer.requireToFailStub.invocations.count, 1)
        XCTAssertTrue(pinchGestureRecognizer.requireToFailStub.invocations.first?.parameters
                        === panGestureHandler.gestureRecognizer)
    }

    func testPitchGestureRecognizerRequiresPanGestureRecognizerToFail() throws {
        let pitchGestureRecognizer = try XCTUnwrap(pitchGestureHandler.gestureRecognizer as? MockGestureRecognizer)

        XCTAssertEqual(pitchGestureRecognizer.requireToFailStub.invocations.count, 1)
        XCTAssertTrue(pitchGestureRecognizer.requireToFailStub.invocations.first?.parameters
                        === panGestureHandler.gestureRecognizer)
    }

    func testQuickZoomGestureRecognizerRequiresDoubleTapToZoomInGestureRecognizerToFail() throws {
        let quickZoomGestureRecognizer = try XCTUnwrap(quickZoomGestureHandler.gestureRecognizer as? MockGestureRecognizer)

        XCTAssertEqual(quickZoomGestureRecognizer.requireToFailStub.invocations.count, 1)
        XCTAssertTrue(quickZoomGestureRecognizer.requireToFailStub.invocations.first?.parameters
                        === doubleTapToZoomInGestureHandler.gestureRecognizer)
    }

    func testSingleTapGestureRecognizerRequiresDoubleTapToZoomInGestureRecognizerToFail() throws {
        let singleTapGestureRecognizer = try XCTUnwrap(singleTapGestureHandler.gestureRecognizer as? MockGestureRecognizer)

        XCTAssertEqual(singleTapGestureRecognizer.requireToFailStub.invocations.count, 1)
        XCTAssertTrue(singleTapGestureRecognizer.requireToFailStub.invocations.first?.parameters
                        === doubleTapToZoomInGestureHandler.gestureRecognizer)
    }

    func testGestureBegan() {
        let gestureType = GestureType.allCases.randomElement()!

        gestureManager.gestureBegan(for: gestureType)

        XCTAssertEqual(delegate.gestureDidBeginStub.invocations.count, 1, "GestureBegan should have been invoked once. It was called \(delegate.gestureDidBeginStub.invocations.count) times.")
        XCTAssertTrue(delegate.gestureDidBeginStub.invocations.first?.parameters.gestureManager === gestureManager)
        XCTAssertEqual(delegate.gestureDidBeginStub.invocations.first?.parameters.gestureType, gestureType)
        XCTAssertEqual(mapboxMap.beginGestureStub.invocations.count, 1)
    }

    func testGestureEnded() throws {
        let gestureType = GestureType.allCases.randomElement()!
        let willAnimate = Bool.random()
        gestureManager.gestureBegan(for: gestureType)
        gestureManager.gestureEnded(for: gestureType, willAnimate: willAnimate)

        XCTAssertEqual(delegate.gestureDidEndStub.invocations.count, 1, "GestureEnded should have been invoked once. It was called \(delegate.gestureDidEndStub.invocations.count) times.")
        XCTAssertTrue(delegate.gestureDidEndStub.invocations.first?.parameters.gestureManager === gestureManager)
        XCTAssertEqual(delegate.gestureDidEndStub.invocations.first?.parameters.gestureType, gestureType)
        let willAnimateValue = try XCTUnwrap(delegate.gestureDidEndStub.invocations.first?.parameters.willAnimate)
        XCTAssertEqual(willAnimateValue, willAnimate)
        XCTAssertEqual(mapboxMap.endGestureStub.invocations.count, 1)
    }

    func testAnimationEnded() {
        let gestureType = GestureType.allCases.randomElement()!

        gestureManager.animationEnded(for: gestureType)

        XCTAssertEqual(delegate.gestureDidEndAnimatingStub.invocations.count, 1, "animationEnded should have been invoked once. It was called \(delegate.gestureDidEndAnimatingStub.invocations.count) times.")
        XCTAssertTrue(delegate.gestureDidEndAnimatingStub.invocations.first?.parameters.gestureManager === gestureManager)
        XCTAssertEqual(delegate.gestureDidEndAnimatingStub.invocations.first?.parameters.gestureType, gestureType)
    }

    func testOptionsPanEnabled() {
        XCTAssertTrue(gestureManager.options.panEnabled)
        XCTAssertTrue(gestureManager.panGestureRecognizer.isEnabled)

        gestureManager.options.panEnabled = false

        XCTAssertFalse(gestureManager.options.panEnabled)
        XCTAssertFalse(gestureManager.panGestureRecognizer.isEnabled)

        gestureManager.options.panEnabled = true

        XCTAssertTrue(gestureManager.options.panEnabled)
        XCTAssertTrue(gestureManager.panGestureRecognizer.isEnabled)

        gestureManager.panGestureRecognizer.isEnabled = false

        XCTAssertFalse(gestureManager.options.panEnabled)
        XCTAssertFalse(gestureManager.panGestureRecognizer.isEnabled)

        gestureManager.panGestureRecognizer.isEnabled = true

        XCTAssertTrue(gestureManager.options.panEnabled)
        XCTAssertTrue(gestureManager.panGestureRecognizer.isEnabled)
    }

    func testOptionsPinchEnabled() {
        XCTAssertTrue(gestureManager.options.pinchEnabled)
        XCTAssertTrue(gestureManager.pinchGestureRecognizer.isEnabled)

        gestureManager.options.pinchEnabled = false

        XCTAssertFalse(gestureManager.options.pinchEnabled)
        XCTAssertFalse(gestureManager.pinchGestureRecognizer.isEnabled)

        gestureManager.options.pinchEnabled = true

        XCTAssertTrue(gestureManager.options.pinchEnabled)
        XCTAssertTrue(gestureManager.pinchGestureRecognizer.isEnabled)

        gestureManager.pinchGestureRecognizer.isEnabled = false

        XCTAssertFalse(gestureManager.options.pinchEnabled)
        XCTAssertFalse(gestureManager.pinchGestureRecognizer.isEnabled)

        gestureManager.pinchGestureRecognizer.isEnabled = true

        XCTAssertTrue(gestureManager.options.pinchEnabled)
        XCTAssertTrue(gestureManager.pinchGestureRecognizer.isEnabled)
    }

    func testOptionsPitchEnabled() {
        XCTAssertTrue(gestureManager.options.pitchEnabled)
        XCTAssertTrue(gestureManager.pitchGestureRecognizer.isEnabled)

        gestureManager.options.pitchEnabled = false

        XCTAssertFalse(gestureManager.options.pitchEnabled)
        XCTAssertFalse(gestureManager.pitchGestureRecognizer.isEnabled)

        gestureManager.options.pitchEnabled = true

        XCTAssertTrue(gestureManager.options.pitchEnabled)
        XCTAssertTrue(gestureManager.pitchGestureRecognizer.isEnabled)

        gestureManager.pitchGestureRecognizer.isEnabled = false

        XCTAssertFalse(gestureManager.options.pitchEnabled)
        XCTAssertFalse(gestureManager.pitchGestureRecognizer.isEnabled)

        gestureManager.pitchGestureRecognizer.isEnabled = true

        XCTAssertTrue(gestureManager.options.pitchEnabled)
        XCTAssertTrue(gestureManager.pitchGestureRecognizer.isEnabled)
    }

    func testOptionsDoubleTapToZoomInEnabled() {
        XCTAssertTrue(gestureManager.options.doubleTapToZoomInEnabled)
        XCTAssertTrue(gestureManager.doubleTapToZoomInGestureRecognizer.isEnabled)

        gestureManager.options.doubleTapToZoomInEnabled = false

        XCTAssertFalse(gestureManager.options.doubleTapToZoomInEnabled)
        XCTAssertFalse(gestureManager.doubleTapToZoomInGestureRecognizer.isEnabled)

        gestureManager.options.doubleTapToZoomInEnabled = true

        XCTAssertTrue(gestureManager.options.doubleTapToZoomInEnabled)
        XCTAssertTrue(gestureManager.doubleTapToZoomInGestureRecognizer.isEnabled)

        gestureManager.doubleTapToZoomInGestureRecognizer.isEnabled = false

        XCTAssertFalse(gestureManager.options.doubleTapToZoomInEnabled)
        XCTAssertFalse(gestureManager.doubleTapToZoomInGestureRecognizer.isEnabled)

        gestureManager.doubleTapToZoomInGestureRecognizer.isEnabled = true

        XCTAssertTrue(gestureManager.options.doubleTapToZoomInEnabled)
        XCTAssertTrue(gestureManager.doubleTapToZoomInGestureRecognizer.isEnabled)
    }

    func testOptionsDoubleTouchToZoomOutEnabled() {
        XCTAssertTrue(gestureManager.options.doubleTouchToZoomOutEnabled)
        XCTAssertTrue(gestureManager.doubleTouchToZoomOutGestureRecognizer.isEnabled)

        gestureManager.options.doubleTouchToZoomOutEnabled = false

        XCTAssertFalse(gestureManager.options.doubleTouchToZoomOutEnabled)
        XCTAssertFalse(gestureManager.doubleTouchToZoomOutGestureRecognizer.isEnabled)

        gestureManager.options.doubleTouchToZoomOutEnabled = true

        XCTAssertTrue(gestureManager.options.doubleTouchToZoomOutEnabled)
        XCTAssertTrue(gestureManager.doubleTouchToZoomOutGestureRecognizer.isEnabled)

        gestureManager.doubleTouchToZoomOutGestureRecognizer.isEnabled = false

        XCTAssertFalse(gestureManager.options.doubleTouchToZoomOutEnabled)
        XCTAssertFalse(gestureManager.doubleTouchToZoomOutGestureRecognizer.isEnabled)

        gestureManager.doubleTouchToZoomOutGestureRecognizer.isEnabled = true

        XCTAssertTrue(gestureManager.options.doubleTouchToZoomOutEnabled)
        XCTAssertTrue(gestureManager.doubleTouchToZoomOutGestureRecognizer.isEnabled)
    }

    func testOptionsQuickZoomEnabled() {
        XCTAssertTrue(gestureManager.options.quickZoomEnabled)
        XCTAssertTrue(gestureManager.quickZoomGestureRecognizer.isEnabled)

        gestureManager.options.quickZoomEnabled = false

        XCTAssertFalse(gestureManager.options.quickZoomEnabled)
        XCTAssertFalse(gestureManager.quickZoomGestureRecognizer.isEnabled)

        gestureManager.options.quickZoomEnabled = true

        XCTAssertTrue(gestureManager.options.quickZoomEnabled)
        XCTAssertTrue(gestureManager.quickZoomGestureRecognizer.isEnabled)

        gestureManager.quickZoomGestureRecognizer.isEnabled = false

        XCTAssertFalse(gestureManager.options.quickZoomEnabled)
        XCTAssertFalse(gestureManager.quickZoomGestureRecognizer.isEnabled)

        gestureManager.quickZoomGestureRecognizer.isEnabled = true

        XCTAssertTrue(gestureManager.options.quickZoomEnabled)
        XCTAssertTrue(gestureManager.quickZoomGestureRecognizer.isEnabled)
    }

    func testOptionsPanDecelerationFactor() {
        XCTAssertEqual(gestureManager.options.panDecelerationFactor, UIScrollView.DecelerationRate.normal.rawValue)
        XCTAssertEqual(panGestureHandler.decelerationFactor, UIScrollView.DecelerationRate.normal.rawValue)

        gestureManager.options.panDecelerationFactor = UIScrollView.DecelerationRate.fast.rawValue

        XCTAssertEqual(gestureManager.options.panDecelerationFactor, UIScrollView.DecelerationRate.fast.rawValue)
        XCTAssertEqual(panGestureHandler.decelerationFactor, UIScrollView.DecelerationRate.fast.rawValue)

        gestureManager.options.panDecelerationFactor = UIScrollView.DecelerationRate.normal.rawValue

        XCTAssertEqual(gestureManager.options.panDecelerationFactor, UIScrollView.DecelerationRate.normal.rawValue)
        XCTAssertEqual(panGestureHandler.decelerationFactor, UIScrollView.DecelerationRate.normal.rawValue)

        panGestureHandler.decelerationFactor = UIScrollView.DecelerationRate.fast.rawValue

        XCTAssertEqual(gestureManager.options.panDecelerationFactor, UIScrollView.DecelerationRate.fast.rawValue)
        XCTAssertEqual(panGestureHandler.decelerationFactor, UIScrollView.DecelerationRate.fast.rawValue)

        panGestureHandler.decelerationFactor = UIScrollView.DecelerationRate.normal.rawValue

        XCTAssertEqual(gestureManager.options.panDecelerationFactor, UIScrollView.DecelerationRate.normal.rawValue)
        XCTAssertEqual(panGestureHandler.decelerationFactor, UIScrollView.DecelerationRate.normal.rawValue)
    }

    func testOptionsPanMode() {
        XCTAssertEqual(gestureManager.options.panMode, .horizontalAndVertical)
        XCTAssertEqual(panGestureHandler.panMode, .horizontalAndVertical)

        gestureManager.options.panMode = .horizontal

        XCTAssertEqual(gestureManager.options.panMode, .horizontal)
        XCTAssertEqual(panGestureHandler.panMode, .horizontal)

        gestureManager.options.panMode = .vertical

        XCTAssertEqual(gestureManager.options.panMode, .vertical)
        XCTAssertEqual(panGestureHandler.panMode, .vertical)

        panGestureHandler.panMode = .horizontalAndVertical

        XCTAssertEqual(gestureManager.options.panMode, .horizontalAndVertical)
        XCTAssertEqual(panGestureHandler.panMode, .horizontalAndVertical)

        panGestureHandler.panMode = [.horizontal, .vertical].randomElement()!

        XCTAssertEqual(gestureManager.options.panMode, panGestureHandler.panMode)
    }

    func testOptionsRotateEnabled() {
        XCTAssertTrue(gestureManager.options.rotateEnabled)
        XCTAssertTrue(gestureManager.rotateGestureRecognizer.isEnabled)

        gestureManager.options.rotateEnabled = false

        XCTAssertFalse(gestureManager.options.rotateEnabled)
        XCTAssertFalse(gestureManager.rotateGestureRecognizer.isEnabled)

        gestureManager.options.rotateEnabled = true

        XCTAssertTrue(gestureManager.options.rotateEnabled)
        XCTAssertTrue(gestureManager.rotateGestureRecognizer.isEnabled)

        gestureManager.rotateGestureRecognizer.isEnabled = false

        XCTAssertFalse(gestureManager.options.rotateEnabled)
        XCTAssertFalse(gestureManager.rotateGestureRecognizer.isEnabled)

        gestureManager.rotateGestureRecognizer.isEnabled = true

        XCTAssertTrue(gestureManager.options.rotateEnabled)
        XCTAssertTrue(gestureManager.rotateGestureRecognizer.isEnabled)
    }

    func testOptionsPinchZoomEnabled() {
        XCTAssertTrue(gestureManager.options.pinchZoomEnabled)
        XCTAssertTrue(pinchGestureHandler.zoomEnabled)

        gestureManager.options.pinchZoomEnabled = false

        XCTAssertFalse(gestureManager.options.pinchZoomEnabled)
        XCTAssertFalse(pinchGestureHandler.zoomEnabled)

        gestureManager.options.pinchZoomEnabled = true

        XCTAssertTrue(gestureManager.options.pinchZoomEnabled)
        XCTAssertTrue(pinchGestureHandler.zoomEnabled)

        pinchGestureHandler.zoomEnabled = false

        XCTAssertFalse(gestureManager.options.pinchZoomEnabled)
        XCTAssertFalse(pinchGestureHandler.zoomEnabled)

        pinchGestureHandler.zoomEnabled = true

        XCTAssertTrue(gestureManager.options.pinchZoomEnabled)
        XCTAssertTrue(pinchGestureHandler.zoomEnabled)
    }

    func testOptionsPinchPanEnabled() {
        XCTAssertTrue(gestureManager.options.pinchPanEnabled)
        XCTAssertTrue(pinchGestureHandler.panEnabled)

        gestureManager.options.pinchPanEnabled = false

        XCTAssertFalse(gestureManager.options.pinchPanEnabled)
        XCTAssertFalse(pinchGestureHandler.panEnabled)

        gestureManager.options.pinchPanEnabled = true

        XCTAssertTrue(gestureManager.options.pinchPanEnabled)
        XCTAssertTrue(pinchGestureHandler.panEnabled)

        pinchGestureHandler.panEnabled = false

        XCTAssertFalse(gestureManager.options.pinchPanEnabled)
        XCTAssertFalse(pinchGestureHandler.panEnabled)

        pinchGestureHandler.panEnabled = true

        XCTAssertTrue(gestureManager.options.pinchPanEnabled)
        XCTAssertTrue(pinchGestureHandler.panEnabled)
    }

    func testOptionsFocalPoint() {
        XCTAssertNil(gestureManager.options.focalPoint)
        XCTAssertNil(doubleTapToZoomInGestureHandler.focalPoint)
        XCTAssertNil(doubleTouchToZoomOutGestureHandler.focalPoint)
        XCTAssertNil(quickZoomGestureHandler.focalPoint)
        XCTAssertNil(pinchGestureHandler.focalPoint)

        let firstFocalPoint = CGPoint.random()
        gestureManager.options.focalPoint = firstFocalPoint

        XCTAssertEqual(gestureManager.options.focalPoint, firstFocalPoint)
        XCTAssertEqual(doubleTapToZoomInGestureHandler.focalPoint, firstFocalPoint)
        XCTAssertEqual(doubleTouchToZoomOutGestureHandler.focalPoint, firstFocalPoint)
        XCTAssertEqual(quickZoomGestureHandler.focalPoint, firstFocalPoint)
        XCTAssertEqual(pinchGestureHandler.focalPoint, firstFocalPoint)
        XCTAssertEqual(rotateGestureHandler.focalPoint, firstFocalPoint)

        gestureManager.options.focalPoint = nil

        XCTAssertNil(doubleTapToZoomInGestureHandler.focalPoint)
        XCTAssertNil(doubleTouchToZoomOutGestureHandler.focalPoint)
        XCTAssertNil(quickZoomGestureHandler.focalPoint)
        XCTAssertNil(pinchGestureHandler.focalPoint)
        XCTAssertNil(rotateGestureHandler.focalPoint)
    }

    func testOptionsSimultaneousRotateAndPinchZoomEnabled() {
        XCTAssertTrue(gestureManager.options.simultaneousRotateAndPinchZoomEnabled)
        XCTAssertTrue(rotateGestureHandler.simultaneousRotateAndPinchZoomEnabled)
        XCTAssertTrue(pinchGestureHandler.simultaneousRotateAndPinchZoomEnabled)

        gestureManager.options.simultaneousRotateAndPinchZoomEnabled = false

        XCTAssertFalse(gestureManager.options.simultaneousRotateAndPinchZoomEnabled)
        XCTAssertFalse(rotateGestureHandler.simultaneousRotateAndPinchZoomEnabled)
        XCTAssertFalse(pinchGestureHandler.simultaneousRotateAndPinchZoomEnabled)
    }

    func testBalancedConsecutivePinchDelegateEvents() {
        gestureManager.gestureBegan(for: .pinch)
        XCTAssertEqual(delegate.gestureDidBeginStub.invocations.count, 1)

        gestureManager.gestureBegan(for: .pinch)

        XCTAssertEqual(delegate.gestureDidBeginStub.invocations.count, 1)

        gestureManager.gestureEnded(for: .pinch, willAnimate: false)
        XCTAssertEqual(delegate.gestureDidEndStub.invocations.count, 0)

        gestureManager.gestureEnded(for: .pinch, willAnimate: false)
        XCTAssertEqual(delegate.gestureDidEndStub.invocations.count, 1)
    }

    func testBalancedMixedPinchDelegateEvents() {
        gestureManager.gestureBegan(for: .pinch)
        gestureManager.gestureBegan(for: .pinch)
        XCTAssertEqual(delegate.gestureDidBeginStub.invocations.count, 1)

        gestureManager.gestureEnded(for: .pinch, willAnimate: false)
        XCTAssertEqual(delegate.gestureDidEndStub.invocations.count, 0)

        gestureManager.gestureBegan(for: .pinch)
        XCTAssertEqual(delegate.gestureDidBeginStub.invocations.count, 1)

        gestureManager.gestureEnded(for: .pinch, willAnimate: false)
        gestureManager.gestureEnded(for: .pinch, willAnimate: false)
        XCTAssertEqual(delegate.gestureDidEndStub.invocations.count, 1)
    }

    func testRotationUpdateScheduledAfterPinchUpdate() {
        gestureManager.pinchGestureHandlerDidUpdateGesture(pinchGestureHandler)

        XCTAssertEqual(rotateGestureHandler.scheduleRotationUpdateIfNeededStub.invocations.count, 1)
    }
}
