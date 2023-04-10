Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBD23A8
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 06:04:28 +0000 (UTC)
Received: (qmail 21736 invoked from network); 10 Apr 2023 06:04:26 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 10 Apr 2023 06:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:content-transfer-encoding:in-reply-to; s=2018; bh=Fb81Chk4/Qz1l
	Xm5baKs4Iud/TbZMIFo7OBI3qNG5cE=; b=r2YHpQ2PCe+ID6Jk43OZRQKVtw0M0
	2s6vkkH9Kfm4mwHGg3w/Y9lylXRz8/+K+1LaDxY75w2rZkbCx7U0SYcl0TKfpQRQ
	MEdsSZBv6JtG3VV87WDaVBomr+mod/YyHJjDfkIfp8MpjPzv5fZTD9iqp66sUM22
	Tk1vZYzwY14OPo=
Received: (qmail 43401 invoked from network); 10 Apr 2023 06:04:26 -0000
Received: by simscan 1.4.0 ppid: 43393, pid: 43397, t: 0.0991s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (bWFuZGF5QG9wZW5tYWlsLmNj@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 10 Apr 2023 06:04:25 -0000
Date: Mon, 10 Apr 2023 09:04:35 +0300
From: Cedric Sodhi <ManDay@openmail.cc>
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Subject: Re: Initial choice of network should consider RSSI?
Message-ID: <ZDOm8xHuEXQ7l1EZ@air>
References: <ZDKinaeLzoAvaIb1@air>
 <9fcce33b-22ad-bb56-d5d3-724450b709b6@gmail.com>
 <CAPv5Ue6KEZVxT2Mb15bBH_8n53abvJbu_+aCTHJgP9ODU3AT5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPv5Ue6KEZVxT2Mb15bBH_8n53abvJbu_+aCTHJgP9ODU3AT5Q@mail.gmail.com>

Hello and thank you for the responses.

Denis, perhaps I misunderstood something, my description wasn't clear or/and (most likely, after I looked at iwd -d), my diagnosis was wrong in the first place, but I thought that the problem was that iwd will connect to a network as soon as a network can be connected to and it will not _revise_ that decision (connect to a better network afterwards). That would become a problem if a "bad" network becomes known moments before the "good" network becomes known.

Looking at iwd -d, however, I get the following list, before it attempt to connect to BAD_NETWORK

src/station.c:station_add_seen_bss() Processing BSS '24:5a:4c:25:f4:71' with SSID: BAD_NETWORK, freq: 5220, rank: 736, strength: -7200, data_rate: 90.0
src/station.c:station_add_seen_bss() Added new Network "BAD_NETWORK" security psk
src/station.c:station_add_seen_bss() Processing BSS '68:72:51:48:72:c2' with SSID: GOOD_NETWORK, freq: 2412, rank: 492, strength: -5400, data_rate: 72.2
src/station.c:station_add_seen_bss() Added new Network "GOOD_NETWORK" security psk
src/station.c:station_add_seen_bss() Processing BSS '24:5a:4c:24:f4:71' with SSID: BAD_NETWORK, freq: 2462, rank: 472, strength: -7300, data_rate: 57.8
src/station.c:station_add_seen_bss() Processing BSS 'cc:2d:21:5d:dd:95' with SSID: BAD_NETWORK3, freq: 5240, rank: 443, strength: -7600, data_rate: 65.0
src/station.c:station_add_seen_bss() Added new Network "BAD_NETWORK3" security psk
src/station.c:station_add_seen_bss() Processing BSS 'cc:2d:21:5d:dd:91' with SSID: BAD_NETWORK2, freq: 2417, rank: 197, strength: -7400, data_rate: 28.9
src/station.c:station_add_seen_bss() Added new Network "BAD_NETWORK2" security psk
src/station.c:station_add_seen_bss() Processing BSS '24:5a:4c:24:f4:73' with SSID: BAD_NETWORK, freq: 2462, rank: 90, strength: -8300, data_rate: 11.0
src/station.c:station_add_seen_bss() Processing BSS 'd8:32:14:ee:a3:d1' with SSID: BAD_NETWORK2, freq: 2422, rank: 37, strength: -8500, data_rate: 5.5

so from what you write James, I think the problem lies in the estimated data rate, given how it appears high on the network with bad RSSI.

I suspect the recommended course of action at this point is just blacklist the station which seems to yield a "misleading high" data rate!

Unless my assumption about how iwd doesn't "revise" network choices during an initial scan period is somehow valid or related to my probelem, I suppose this is an issue with the particular station then and has nothing to do with iwd's behaviour, so thanks for the help!

Cedric

On Sun, Apr 09, 2023 at 10:07:34AM -0700, James Prestwood wrote:
>    Hi Cedric,
> 
>    On Sun, Apr 9, 2023, 9:58 AM Denis Kenzior <[1]denkenz@gmail.com> wrote:
> 
>      Hi Cedric,
> 
>      On 4/9/23 06:33, Cedric Sodhi wrote:
>      > Hello,
>      >
>      > I have a permanent problem with IWD when multiple known networks
>      (different SSIDs) are in range: With a large probably (although it is
>      most likely just random, depending on when the beacons fire) IWD manages
>      to connect to a network with an unusable low RSSI while better networks
>      are available.
>      >
>      > I suspect there is currently no logic in place which would somehow
>      work in favor of making a "good" choice? RoamThreshold, for example,
>      doesn't seem to apply and InitialPeriodicScanInterval seems to have no
>      effect either, given that the (initial) connection to the (bad) network
>      happens immediately before InitialPeriodicScanInterval passed, and that
>      choice does not seem to be revised even if the better network becomes
>      visible within InitialPeriodicScanInterval.
> 
>      Periodic scans are attempted every N seconds, with exponentially
>      increasing N if
>      no connectable network was found.  InitialPeriodicScanInterval simply
>      sets the
>      initial timeout N.  It isn't that iwd scans constantly during that
>      period.
> 
>      Once a periodic scan completes, and there's something to connect to, iwd
>      attempts to do so.  If there are multiple somethings to connect to, then
>      iwd
>      prioritizes networks based on estimated throughput (this is where the
>      RSSI is
>      taken into account) and which network was most recently used.  There are
>      some
>      other factors.
> 
>      >
>      > Would it possible to either extend the meaning of
>      InitialPeriodicScanInterval or introduce another option which would
>      allow IWD to connect to a better, different SSID (thus not covered by
>      roaming) within an initial period?
>      If you have a more concrete proposal please share it.  And patches are
>      always
>      welcome :)
> 
>    It would also be helpful to see the debug logs too see why IWD chose the
>    network it did. This would answer questions I have like:
>    Did the scan only see one network?
>    What was the estimated data rate of both networks?
>    How good/bad was the RSSI between the two networks in question?
>    Thanks,
>    James
> 
>      Regards,
>      -Denis
> 
> References
> 
>    Visible links
>    1. mailto:denkenz@gmail.com
