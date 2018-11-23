// Copyright (c) 2015-present Mattermost, Inc. All Rights Reserved.
// See LICENSE.txt for license information.

import React from 'react';

import ChannelView from 'components/channel_view/index';

import {connect} from "react-redux";
import {
  getSortedPublicChannelIds,
  getSortedPublicChannelWithUnreadsIds,
} from "mattermost-redux/selectors/entities/channels";
import {getConfig} from "mattermost-redux/selectors/entities/general";

import {Preferences} from "mattermost-redux/constants/index";
import {GroupUnreadChannels} from "../../utils/constants";

class MultiChannelView extends React.PureComponent {
  render() {
    return (this.props.publicChannelIds || [])
      .map(channelId => <ChannelView key={channelId} channelId={channelId}/>)
  }
}

// Patrik: this should be more simple
function mapStateToProps(state) {
  const config = getConfig(state);
  let publicChannelIds;

  const showUnreadSection = config.ExperimentalGroupUnreadChannels !== GroupUnreadChannels.DISABLED && getBoolPreference(
    state,
    Preferences.CATEGORY_SIDEBAR_SETTINGS,
    'show_unread_section',
    config.ExperimentalGroupUnreadChannels === GroupUnreadChannels.DEFAULT_ON
  );

  const keepChannelIdAsUnread = state.views.channel.keepChannelIdAsUnread;

  if (showUnreadSection) {
    publicChannelIds = getSortedPublicChannelIds(state, keepChannelIdAsUnread);
  } else {
    publicChannelIds = getSortedPublicChannelWithUnreadsIds(state);
  }

  return {
    publicChannelIds,
  };
}

export default connect(mapStateToProps)(MultiChannelView);