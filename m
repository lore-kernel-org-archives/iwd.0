Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A577C;
	Mon,  2 Jan 2023 08:35:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEA3FDB535;
	Mon,  2 Jan 2023 09:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1672648555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b0FipNdNlAGKhCuGCjYwAM/Sj6SxdKwX9fxoLU6Huf4=;
	b=aDqFbjVxP4ncFf3ynqwfup8H/2BcMxEdeYxXXF4wc/aCc6xhBrFLCoXB7GnUvf2dTv2u9y
	kBipS/ko64TtdU6X6hYeBmlQLkIgZSosuo7rse0JYXv4bGaHRrPO9dR1k2unEUgnln53PT
	ObAnVLK1XeEpFEQlugJRpLIIrzV0LdECEVFW2cKIVLCLn6r69VpF16TyeOMxDDo+0+F+pC
	uwYvvaXAUrPi223jCEthcYZkhFdSe40EFC40nhIX+VFfiUWBKueugbqKG6Cv/h/iLrD1WJ
	LXSvoLFTb/rahG4PF7yGlQv8hqxEycVC+ZBeU4RZfQA4dzAHgTUlonIneKkw4g==
Date: Mon, 2 Jan 2023 09:35:54 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jade Lovelace <lists@jade.fyi>
Cc: connman@lists.linux.dev, iwd@lists.linux.dev
Subject: Re: bug: iwd KnownNetworks AutoConnect setting desynchronizes with
 connman's, breaking auto connect
Message-ID: <20230102083554.nindhbg3b4edrgfo@beryllium.lan>
References: <CAFA9we9QrpTmyzBewdiL4gKP52_G_j25NvR2pjpqzBXb2xPnzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA9we9QrpTmyzBewdiL4gKP52_G_j25NvR2pjpqzBXb2xPnzQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Dec 28, 2022 at 02:39:05PM +0100, Jade Lovelace wrote:
> Hi,
> 
> I have been using connman with iwd recently and I've found that the
> autoconnect doesn't seem to work consistently and I often have to
> manually use connmanctl to reconnect to the network.
> 
> This manifests in a strange (to me) way: the network is seen in
> connmanctl but not automatically connected to. I've glanced through
> the Connman iwd plugin code and it's my understanding that the actual
> automatic connection when the network reappears is done by iwd, and
> the Connman plugin merely sends configurations to iwd.

Yes, this is correct. ConnMan disables the auto connect state machine for iwd.

> I can get the AutoConnect variable resynchronized by manually toggling
> it with connmanctl. If I do this, when I put my machine to sleep and
> open it back up, it will reconnect as expected, temporarily resolving
> the issue. My assumption here is that iwd is turning AutoConnect off
> for the network for some unknown reason, and connman is not accounting
> for this change.

ConnMan completle relies on iwd to do the right thing, so this question is more
for the iwd developers. I don't think ConnMan should start fiddling with the
AutoConnect settings after the initial configuration.

> I am using connman-1.41 and iwd-2.0 on NixOS.
> 
> You can see that toggling in the below snippet:
> 
> ~ » busctl get-property net.connman.iwd
> /net/connman/iwd/0000000000000000_psk net.connman.iwd.KnownNetwork
> AutoConnect
> b false
> ^^^^^ ---- On connman startup, the iwd KnownNetwork has AutoConnect = false
> 
> ~ » connmanctl
> connmanctl> services
> *A  REDACTED1            wifi_abcdefabcdef_0000000000000000_managed_psk
> 
> connmanctl> services wifi_abcdefabcdef_0000000000000000_managed_psk
> /net/connman/service/wifi_abcdefabcdef_0000000000000000_managed_psk
>   Type = wifi
>   Security = [ psk ]
>   State = idle
>   Strength = 55
>   Favorite = True
>   Immutable = False
>   AutoConnect = True
>   ^^^^^ ---- However, connman thinks it is true
>   Name = REDACTED1
> 
> connmanctl> config wifi_abcdefabcdef_0000000000000000_managed_psk
> --autoconnect true
> connmanctl> config wifi_abcdefabcdef_0000000000000000_managed_psk
> --autoconnect false
> connmanctl> config wifi_abcdefabcdef_0000000000000000_managed_psk
> --autoconnect true
> ^^^^^ ---- If we manually toggle it back and forth, it will get synced again
> 
> ~ » busctl get-property net.connman.iwd
> /net/connman/iwd/0000000000000000_psk net.connman.iwd.KnownNetwork
> AutoConnect
> b true
> 
> Jade
> 
