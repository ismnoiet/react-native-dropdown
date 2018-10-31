import React, { Component } from 'react'
import {
  requireNativeComponent,
  Platform,
} from 'react-native'
import PropTypes from 'prop-types';

let RNDropdownMenu = null;

if (Platform.OS === 'ios') {
  RNDropdownMenu = requireNativeComponent('RNDropdownMenu', RNDropdownMenuView)
}

export default class RNDropdownMenuView extends Component {
  render() {
    return RNDropdownMenu ?
      <RNDropdownMenu
        {...this.props}
        onChange={(e) => {
          if (this.props.onChange) {
            this.props.onChange(e.nativeEvent);
          }
          console.log('@value: ', e.nativeEvent);
        }}
      />
      :
      null;
  }
}

RNDropdownMenuView.propTypes = {
  exampleProp: PropTypes.string,
};
