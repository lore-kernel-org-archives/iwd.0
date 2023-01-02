Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441520EC;
	Mon,  2 Jan 2023 08:29:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42E7FDB6EE;
	Mon,  2 Jan 2023 09:29:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1672648182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gY8gqt7FmaBrsFkOxWp89KmdBi8T+ErGhZdrv87hArA=;
	b=ulVTPi4QjG7AlccMou56it5+Rl6UTKQVKAINZbOSgGm2h8iPEQBW5vm51BSnIADMpyYwzS
	xv6KQ6woZWQDp36B84HnLP9EFdlgJUP6OPeNIwmQ+9v9htgh4DpaqH0mclli6GQe6zBVON
	vPHasQtWN1KCVto31awMsBqZ47prxq7SfWo5n0jaQ2lUyrkeKXdwwvcER8oQNm+HMf9oP9
	6t2ngt7pGHQyH2n60GD6keqUI5fUFkkkHSEgIizRnTtba2Gu69wV8R4IdVXx8YOHHGau9R
	BRUV5Y6IgEkWHF0KP09H3NpODQVqnXHtKahwkQS9kGMKOtMU0a7MYL/D7zVSxg==
Date: Mon, 2 Jan 2023 09:29:41 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jade Lovelace <lists@jade.fyi>
Cc: connman@lists.linux.dev, iwd@lists.linux.dev
Subject: Re: bug: 802.1x configuration is not turned into an iwd KnownNetwork
Message-ID: <20230102082941.rhlb4dfwzhkvmav7@beryllium.lan>
References: <CAFA9we_ArzwtDidQkEQTL-vEPC2GGnRTqZB7jbx=UZ-R1MkzoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA9we_ArzwtDidQkEQTL-vEPC2GGnRTqZB7jbx=UZ-R1MkzoA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Dec 28, 2022 at 02:16:03PM +0100, Jade Lovelace wrote:
> I just set up an 802.1x configuration with Connman and iwd and it
> seems that Connman is not telling iwd about its network configuration
> files and turning them into iwd KnownNetworks.
> 
> When I create a config file for a network in /var/lib/connman for an
> 802.1x network, then try to connect to it, it will get stuck in
> "association":
> 
> connmanctl> services wifi_9cb6d0f7daaf_7075626c6963726f616d_managed_ieee8021x
> /net/connman/service/wifi_9cb6d0f7daaf_7075626c6963726f616d_managed_ieee8021x
>   Type = wifi
>   Security = [ ieee8021x ]
>   State = association
>   Strength = 56
>   Favorite = True
>   Immutable = True
>   AutoConnect = True
>   Name = publicroam
> 
> I had a think about this and concluded it was probably that connman
> didn't create the known network on the iwd side, which I confirmed by
> manually creating /var/lib/iwd/publicroam.8021x with the correct
> configuration, solving the issue. I suspect that if I was using some
> UI for connman that creates networks via D-Bus rather than via
> configuration files, it might work, but the fact that the connman
> config files don't apply to iwd is inconsistent with the behaviour
> under wpa_supplicant.

ConnMan interacts with iwd only via the D-Bus interface. I can't remember that
we added any code to do any provisioning in iwd (also a quick glance over the
iwd plugin code doesn't ring any bell). Also I couldn't find any API doc in iwd
which covers this topic. So I don't know if it is currently possible to
provision iwd via the D-Bus API.

> I am using connman-1.41 on NixOS.
> 
> Here is my config "publicroam.config":
> 
> [service_publicroam]
> Type=wifi
> Name=publicroam
> EAP=peap
> Phase2=MSCHAPV2
> Identity=<REDACTED>
> Passphrase=<REDACTED>
> 
> Here is the relevant connman log (with iwd debug logging on):
> 
> Dec 28 13:24:34 snowflake connmand[266352]:
> plugins/iwd.c:object_added() net.connman.iwd.Network
> /net/connman/iwd/0/5/7075626c6963726f616d_8021x
> Dec 28 13:24:34 snowflake connmand[266352]:
> plugins/iwd.c:create_network() device /net/connman/iwd/0/5 name
> 'publicroam' type 8021x connected 0 known_network (null)
> Dec 28 13:24:34 snowflake connmand[266352]:
> plugins/iwd.c:station_property_change() /net/connman/iwd/0/5 scanning
> 0
> Dec 28 13:24:34 snowflake connmand[266352]:
> plugins/iwd.c:station_property_change() /net/connman/iwd/0/5 scanning
> 1
> Dec 28 13:24:34 snowflake connmand[266352]: plugins/iwd.c:ordered_networks_cb()
> <<< REDACTED >>>
> Dec 28 13:24:55 snowflake connmand[266352]: EAP type has not been
> found. Most likely ConnMan is not able to find a configuration for
> given 8021X network. Check SSID or Name match with the network name.
> 
> ^^^^^^^ ------ This was when I tried to ask it to connect prior to
> configuring it
> 
> <<< REDACTED >>>
> Dec 28 13:27:04 snowflake connmand[266352]: Adding configuration publicroam
> Dec 28 13:27:04 snowflake connmand[266352]: Adding service
> configuration publicroam
> 
> ^^^^^^^ ------ Then I added a configuration here
> 
> Dec 28 13:27:04 snowflake connmand[266352]:
> plugins/iwd.c:cm_network_connect_cb()
> /net/connman/iwd/0/5/7075626c6963726f616d_8021x connect failed:
> net.connman.iwd.NotConfigured
> 
> ^^^^^^^ ------ But connecting fails
> 
> Jade
> 
