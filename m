Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9B1118
	for <iwd@lists.linux.dev>; Fri,  3 Nov 2023 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki1LOI0j"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so892106b6e.3
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 19:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698977225; x=1699582025; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEf2XxJ1DLen4JiwXv3ZoYLAWNfkwgqTiEqh3ki4+NQ=;
        b=ki1LOI0jS5qHzUtfjhBzr/Rmx1SXMicq7n8+qkeU3BC/tsrYMI7+XilqPK7fduraW5
         WZ8thY2D6us73hegS6lHXcOwdYrm/ATYrmH+jf7mZiei9kaVQQemSznzYKo3VYjc/3Bm
         ja3s7YVXMfSkytLTbZeF+cd96PZWyROhnnM4rgRjCmxLCrWvObX4tSh5ysXZNmawbXei
         LofX2XNgxLltkqDMTqE+uAaRxTR/+tCgLXyyXfJ9E8SHQC2fZ2clcCZOEl+7GXCFCMYN
         7ORPDdNpYvElu+zMPjUQmjGPwOs4ZOlo35Wluyt/kjW7cMegFgkZ4/nNdFEayZ40Wr8C
         q/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698977225; x=1699582025;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEf2XxJ1DLen4JiwXv3ZoYLAWNfkwgqTiEqh3ki4+NQ=;
        b=DW7dgpjfgkEckl24zs3B9F+a94JZsrUz5/2jG7EsXX4R5veGpypxO/ZPI0ZzHXQPbc
         Rzb6jbR1eWaQL61oUeoU2NbZRr4W1+9vrYMR+6KbY9wt0L6g+kpkk6VlRQKnGze5JxjS
         1q+L+Oxn6YtqF/LY3KHur8cD46fKxOr/13HZy9DA3jxNNlHx70yCFgp288dQfrJwpT1b
         pHCbX3EfLdNICjg5gcMEBBfe7p93hHNE25Lp0074OfJDoShx/f/fElP1AFC5q/e3XL3v
         zAlhy1bDl25N5R+A/OYzSZfZ0d72dLuQe2lGNL0VHjJ1lZdbaiEtgYva7DbmOTYGmAO4
         XP7w==
X-Gm-Message-State: AOJu0YzueLeUR7cDxm8C//ti+ElpUvg2I93vKn8fp7HG0+PehBdlFEH6
	8v1XnGIuFeo6gfE+JRTxiDcxXc/sawY=
X-Google-Smtp-Source: AGHT+IH9g9fFSWybCZkrnFipOoYphRExJY8j9hAJ5Lug8m6sEQ3ZYbjj/alDrcz940UFtagoRD72Mw==
X-Received: by 2002:a05:6808:210e:b0:3a1:e17a:b3fb with SMTP id r14-20020a056808210e00b003a1e17ab3fbmr26518206oiw.1.1698977225383;
        Thu, 02 Nov 2023 19:07:05 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bq9-20020a05680823c900b003ae5cb55513sm140270oib.38.2023.11.02.19.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 19:07:04 -0700 (PDT)
Message-ID: <3eb37cc3-431a-45cf-95d9-8b2386f75d0d@gmail.com>
Date: Thu, 2 Nov 2023 21:07:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231031184750.722404-1-prestwoj@gmail.com>
 <20231031184750.722404-7-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231031184750.722404-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/31/23 13:47, James Prestwood wrote:
> PKEX is part of the WFA EasyConnect specification and is
> an additional boostrapping method (like QR codes) for
> exchanging public keys between a configurator and enrollee.
> 
> PKEX operates over wifi and requires a key/code be exchanged
> prior to the protocol. The key is used to encrypt the exchange
> of the boostrapping information, then DPP authentication is
> started immediately aftewards.
> 
> This can be useful for devices which don't have the ability to
> scan a QR code, or even as a more convenient way to share
> wireless credentials if the PSK is very secure (i.e. not a
> human readable string).
> 
> PKEX would be used via the three DBus APIs on a new interface
> SharedCodeDeviceProvisioning.
> 
> ConfigureEnrollee(a{sv}) will start a configurator with a
> static shared code (optionally identifier) passed in as the
> argument to this method.
> 
> StartEnrollee(a{sv}) will start a PKEX enrollee using a static
> shared code (optionally identifier) passed as the argument to
> the method.
> 
> StartConfigurator() will start a PKEX configurator (should be
> already registered) which will query an agent for an enrollees
> shared code. Enrollees are distinguished by the identifier.
> 
> After the PKEX protocol is finished, DPP bootstrapping keys have
> been exchanged and DPP Authentication will start, followed by
> configuration.
> ---
>   doc/device-provisioning-api.txt | 149 ++++++++++++++++++++++++++++++++
>   1 file changed, 149 insertions(+)
> 
> diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
> index ac204f46..3c6fc74e 100644
> --- a/doc/device-provisioning-api.txt
> +++ b/doc/device-provisioning-api.txt
> @@ -71,3 +71,152 @@ Properties	boolean Started [readonly]
>   
>   			Indicates the DPP URI. This property is only available
>   			when Started is true.
> +
> +
> +Interface	net.connman.iwd.SharedCodeDeviceProvisioning [Experimental]
> +Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
> +
> +		ConfigureEnrollee(a{sv})
> +
> +			Starts a DPP configurator using a shared code (and
> +			optionally identifier) set in the dictionary argument.
> +			Valid dictionary keys are:
> +
> +			string Code
> +				The shared code to use. The code used by both
> +				parties (configurator and enrollee) must match.
> +
> +			string Identifier
> +				An optional identifier. The identifier used by
> +				both parties must match. Per the DPP spec the
> +				identifier "shall be a UTF-8 string not greater
> +				than eighty (80) octets"
> +
> +			As with the DeviceProvisioning interface, configurators
> +			must be connected to the network they wish to configure
> +			in order to start.
> +
> +			Once started a configurator (acting as a responder) will
> +			listen on the currently connected channel for an
> +			enrollee's initial exchange request which will kick off
> +			the shared code bootstrapping protocol (PKEX). Once
> +			completed DPP will start automatically. Only one
> +			enrollee can be configured per call to
> +			ConfigureEnrollee, i.e. once PKEX/DPP is has finished

"is has finished"?

> +			(including failure) the configurator will stop.
> +
> +			The SharedCode methods have an eventual timeout and will
> +			stop automatically after 2 minutes.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.NotConnected
> +						net.connman.InvalidArguments
> +
> +		StartEnrollee(a{sv})
> +
> +			Starts a DPP enrollee using a shared code (and
> +			optionally identifier) set in the dictionary argument
> +			(described above in ConfigureEnrollee).
> +
> +			As with the device provisioning interface, enrollees
> +			must be disconnected in order to start.
> +
> +			Once started an enrollee (acting as an initiator) will
> +			iterate channels sending out broadcast exchange requests
> +			waiting for a response from a configurator. A response
> +			will kick off the shared code bootstrapping protocol
> +			(PKEX), followed by DPP if successful. Once the
> +			protocols have completed, or failed, the enrollee will
> +			stop. If failed, StartEnrollee will need to be called
> +			again to retry.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.InvalidArguments
> +
> +		StartConfigurator()

You are missing return parameters for all of these methods.  Also seems like 
Stop() method isn't documented.

> +
> +			Start a shared code configurator using an agent to
> +			obtain the shared code. This method is meant for an
> +			automated use case where a configurator is capable of
> +			configuring multiple enrollees, and distinguishing
> +			between them by their identifier.
> +
> +			Prior to calling, a SharedCodeAgent must be registered
> +			using RegisterSharedCodeAgent. Only a single agent can
> +			be registered per SharedCodeInterface.

So the one thing to watch out for is that DPP interface can come and go, unlike 
the Manager interface.  Since StartConfigurator() has to be called for each 
protocol attempt, providing the agent as an argument might be be a nicer 
shortcut?  The API is marked experimental, so we can always change this.  You 
will probably know more once you try to implement the API.

Also, it seems to me that StartConfigurator implies that the agent is active. 
If the agent goes away, StartConfigurator() should be aborted, no?

> +
> +			This method behaves nearly the same as ConfigureEnrollee
> +			except upon receiving an enrollees first exchange
> +			request the registered agent will be asked for the
> +			shared code using the RequestSharedCode method.
> +
> +			Though the agent can provide shared codes for multiple
> +			enrollees, this method will only configure a single
> +			enrollee at a time. Once completed it will need to be
> +			called again to configure additional enrollees.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.NotConnected
> +						net.connman.iwd.NoAgent
> +
> +		void RegisterSharedCodeAgent(object path)
> +
> +			Register the agent object for servicing shared code
> +			requests on the net.connman.iwd.SharedCodeAgent
> +			interface. There may only be one agent registered at a
> +			time per SharedCodeDeviceProvisioning interface.
> +
> +			Possible Errors:	[service].Error.InvalidArguments
> +						[service].Error.AlreadyExists
> +
> +		void UnregisterSharedCodeAgent()
> +
> +			Unregister an existing agent.
> +
> +			Possible Errors:	[service].Error.NotFound
> +
> +Properties	boolean Started [readonly]
> +
> +			True if shared code device provisioning is currently
> +			active. (configurator or enrollee is started)
> +
> +		string Role [readonly, optional]
> +
> +			Indicates the DPP role. Possible values are "enrollee"
> +			or "configurator". This property is only available when
> +			Started is true.
> +
> +SharedCodeAgent hierarchy
> +=========================
> +
> +Service		unique name
> +Interface	net.connman.iwd.SharedCodeAgent [Experimental]
> +Object path	freely definable
> +
> +Methods		void Release() [noreply]
> +
> +			This method gets called when the service daemon
> +			unregisters the agent.

You don't actually call this method.

> +
> +		string RequestSharedCode(object network, string identifier)
> +
> +			This method gets called when a shared code is requested
> +			for a particular enrollee, distingushed by the
> +			identifier. The shared code agent should lookup the
> +			identifier and return the shared code, or return an
> +			error if not found.

Looks like you don't actually call the agent with the network object?

> +
> +			Possible Errors:	[service].Error.Canceled
> +						[service].Error.NotFound
> +
> +		void Cancel(string reason) [noreply]
> +
> +			This method gets called to indicate that the agent
> +			request failed before a reply was returned. The
> +			argument will indicate why the request is being
> +			cancelled and may be "user-canceled", "timed-out" or
> +			"shutdown".

You don't call this method either.
> +
> +Examples	Requesting a shared code for an enrollee identified by "foo"
> +
> +			RequestSharedCode("foo") ==> "super_secret_code"

This signature incorrect as well?

Regards,
-Denis
