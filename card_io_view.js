let React = require('react-native');
let { requireNativeComponent, NativeAppEventEmitter } = React;

let CardIOView = React.createClass({
  displayName: 'CardIOView',

  propTypes: {
    languageOrLocale: React.PropTypes.oneOf([
      'ar','da','de','en','en_AU','en_GB','es','es_MX','fr','he','is','it','ja','ko','ms',
      'nb','nl','pl','pt','pt_BR','ru','sv','th','tr','zh-Hans','zh-Hant','zh-Hant_TW',
    ]),
    guideColor: React.PropTypes.string,
    useCardIOLogo: React.PropTypes.bool,
    hideCardIOLogo: React.PropTypes.bool,
    allowFreelyRotatingCardGuide: React.PropTypes.bool,
    scanInstructions: React.PropTypes.string,
    scanOverlayView: React.PropTypes.element,
    scanExpiry: React.PropTypes.bool,
    scannedImageDuration: React.PropTypes.number,
    detectionMode: React.PropTypes.oneOf([
      'cardImageAndNumber', 
      'cardImageOnly',
      'automatic',
    ]),
    didScanCard: React.PropTypes.func,
    hidden: React.PropTypes.bool,
  },

  statics: {
    cardImageAndNumber: 'cardImageAndNumber',
    cardImageOnly: 'cardImageOnly',
    automatic: 'automatic',
  },

  getDefaultProps() {
    return {
      didScanCard: () => {},
    };
  },

  componentWillMount() {
    _listener = NativeAppEventEmitter.addListener('didScanCard', this.props.didScanCard);
  },

  componentWillUnmount() {
    if (_listener) _listener.remove();
  },

  render() {
    return <RCTCardIOView {...this.props} />;
  },

  _listener: null,
});

let RCTCardIOView = requireNativeComponent('RCTCardIOView', CardIOView);

module.exports = CardIOView;