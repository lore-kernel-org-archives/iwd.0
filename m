Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080658836
	for <iwd@lists.linux.dev>; Fri,  3 Nov 2023 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq/zBKlK"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-66d093265dfso10733266d6.3
        for <iwd@lists.linux.dev>; Fri, 03 Nov 2023 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699010697; x=1699615497; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gV5zSqjPVZsFq4UCpEpdyEXjg8v3iIrgp7FG96EWHUk=;
        b=Tq/zBKlKmi0qfxJd+RJ3hOmhYRFDteBYC1lMXwhoVUKGP/H1qF+2V6B4ZFHYmFeu+u
         grhq23gUVbZOMetciz7cP4GSrno0qWcpzuqlIkI/3lK3YFVhFWRYDW6m7nb3xkc9MvIV
         5WeLoJvWcCwTbQR6LaYjE/zM+gZ1kvR+HhBrydtXK1WzRobMOWsaj8M3fvrBg0I6OR+E
         px/Bv/VYw1zPJpvLPWH6ITtwQXNPEXCe2GzS1Bp7cIiVCphqzFlLTzLQJTiCbdIz6DWF
         ihKFbMAw4lI6VuNUQzCZaUNKrXIy1ozfqjZjCFG0lWcKRf6JrLgTK5EX7MTNBWbHsgkJ
         4nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010697; x=1699615497;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gV5zSqjPVZsFq4UCpEpdyEXjg8v3iIrgp7FG96EWHUk=;
        b=TXOyufzywksLx2e5vWFGXa3cYqXDNTV9IaLu5RyVAPskKDnoPL4DDs5D1mY86JxAqM
         WzNZrToXn05jUmQaBRft/HtCY5RJpmfNaiO/0C4NOaO80IL4JSNmNACU2LQ7bLxQoZgH
         /bmQRen3SntX+fCjDaW+P2mhwDEGVMc0pXZnOR1WyoUrVERaKtLYfKz4sMBGCsWxHhCW
         hSQz2aMYrZyudT+TuCvjeqfzjTTI8qe1gpyMrEfAy02hyr8lCyAZ/JOAvWY8BuTaK0iU
         Hvwy00T3/cuyFWZWP90wkDZlXVAlL4XJdB2RNy0lPlXmaxi42Uh1IM13U74SCA1sXY3+
         mOsQ==
X-Gm-Message-State: AOJu0Yy65PWerUOTVYVvtFPs04yNQXGQJMf79JthCwqSeyWPwQFaq6Ps
	g4tD98CWk3CsOkbs8QjFX84=
X-Google-Smtp-Source: AGHT+IE5cjdyUG33zIeTGOtZHbGufnrkiOH6HcsPrKf3NIHsGwLN/rxrAb+IH33XK7Az0Tv+Muh0QQ==
X-Received: by 2002:a0c:aadd:0:b0:66f:ba6e:73e8 with SMTP id g29-20020a0caadd000000b0066fba6e73e8mr19480467qvb.41.1699010696611;
        Fri, 03 Nov 2023 04:24:56 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id cu8-20020a05621417c800b0066d1e71e515sm642421qvb.113.2023.11.03.04.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 04:24:56 -0700 (PDT)
Message-ID: <0cbc142f-948f-4778-b5b3-7b9bd42e4393@gmail.com>
Date: Fri, 3 Nov 2023 04:24:51 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] doc: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231031184750.722404-1-prestwoj@gmail.com>
 <20231031184750.722404-7-prestwoj@gmail.com>
 <3eb37cc3-431a-45cf-95d9-8b2386f75d0d@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <3eb37cc3-431a-45cf-95d9-8b2386f75d0d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/2/23 7:07 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/31/23 13:47, James Prestwood wrote:
>> PKEX is part of the WFA EasyConnect specification and is
>> an additional boostrapping method (like QR codes) for
>> exchanging public keys between a configurator and enrollee.
>>
>> PKEX operates over wifi and requires a key/code be exchanged
>> prior to the protocol. The key is used to encrypt the exchange
>> of the boostrapping information, then DPP authentication is
>> started immediately aftewards.
>>
>> This can be useful for devices which don't have the ability to
>> scan a QR code, or even as a more convenient way to share
>> wireless credentials if the PSK is very secure (i.e. not a
>> human readable string).
>>
>> PKEX would be used via the three DBus APIs on a new interface
>> SharedCodeDeviceProvisioning.
>>
>> ConfigureEnrollee(a{sv}) will start a configurator with a
>> static shared code (optionally identifier) passed in as the
>> argument to this method.
>>
>> StartEnrollee(a{sv}) will start a PKEX enrollee using a static
>> shared code (optionally identifier) passed as the argument to
>> the method.
>>
>> StartConfigurator() will start a PKEX configurator (should be
>> already registered) which will query an agent for an enrollees
>> shared code. Enrollees are distinguished by the identifier.
>>
>> After the PKEX protocol is finished, DPP bootstrapping keys have
>> been exchanged and DPP Authentication will start, followed by
>> configuration.
>> ---
>>   doc/device-provisioning-api.txt | 149 ++++++++++++++++++++++++++++++++
>>   1 file changed, 149 insertions(+)
>>
>> diff --git a/doc/device-provisioning-api.txt 
>> b/doc/device-provisioning-api.txt
>> index ac204f46..3c6fc74e 100644
>> --- a/doc/device-provisioning-api.txt
>> +++ b/doc/device-provisioning-api.txt
>> @@ -71,3 +71,152 @@ Properties    boolean Started [readonly]
>>               Indicates the DPP URI. This property is only available
>>               when Started is true.
>> +
>> +
>> +Interface    net.connman.iwd.SharedCodeDeviceProvisioning [Experimental]
>> +Object path    /net/connman/iwd/{phy0,phy1,...}/{1,2,...}
>> +
>> +        ConfigureEnrollee(a{sv})
>> +
>> +            Starts a DPP configurator using a shared code (and
>> +            optionally identifier) set in the dictionary argument.
>> +            Valid dictionary keys are:
>> +
>> +            string Code
>> +                The shared code to use. The code used by both
>> +                parties (configurator and enrollee) must match.
>> +
>> +            string Identifier
>> +                An optional identifier. The identifier used by
>> +                both parties must match. Per the DPP spec the
>> +                identifier "shall be a UTF-8 string not greater
>> +                than eighty (80) octets"
>> +
>> +            As with the DeviceProvisioning interface, configurators
>> +            must be connected to the network they wish to configure
>> +            in order to start.
>> +
>> +            Once started a configurator (acting as a responder) will
>> +            listen on the currently connected channel for an
>> +            enrollee's initial exchange request which will kick off
>> +            the shared code bootstrapping protocol (PKEX). Once
>> +            completed DPP will start automatically. Only one
>> +            enrollee can be configured per call to
>> +            ConfigureEnrollee, i.e. once PKEX/DPP is has finished
> 
> "is has finished"?
> 
>> +            (including failure) the configurator will stop.
>> +
>> +            The SharedCode methods have an eventual timeout and will
>> +            stop automatically after 2 minutes.
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.NotConnected
>> +                        net.connman.InvalidArguments
>> +
>> +        StartEnrollee(a{sv})
>> +
>> +            Starts a DPP enrollee using a shared code (and
>> +            optionally identifier) set in the dictionary argument
>> +            (described above in ConfigureEnrollee).
>> +
>> +            As with the device provisioning interface, enrollees
>> +            must be disconnected in order to start.
>> +
>> +            Once started an enrollee (acting as an initiator) will
>> +            iterate channels sending out broadcast exchange requests
>> +            waiting for a response from a configurator. A response
>> +            will kick off the shared code bootstrapping protocol
>> +            (PKEX), followed by DPP if successful. Once the
>> +            protocols have completed, or failed, the enrollee will
>> +            stop. If failed, StartEnrollee will need to be called
>> +            again to retry.
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.InvalidArguments
>> +
>> +        StartConfigurator()
> 
> You are missing return parameters for all of these methods.  Also seems 
> like Stop() method isn't documented.
> 
>> +
>> +            Start a shared code configurator using an agent to
>> +            obtain the shared code. This method is meant for an
>> +            automated use case where a configurator is capable of
>> +            configuring multiple enrollees, and distinguishing
>> +            between them by their identifier.
>> +
>> +            Prior to calling, a SharedCodeAgent must be registered
>> +            using RegisterSharedCodeAgent. Only a single agent can
>> +            be registered per SharedCodeInterface.
> 
> So the one thing to watch out for is that DPP interface can come and go, 
> unlike the Manager interface.  Since StartConfigurator() has to be 
> called for each protocol attempt, providing the agent as an argument 
> might be be a nicer shortcut?  The API is marked experimental, so we can 
> always change this.  You will probably know more once you try to 
> implement the API.

I had that thought too but was just keeping things consistent. But I'm 
fine removing the register APIs and just passing the path here.

> 
> Also, it seems to me that StartConfigurator implies that the agent is 
> active. If the agent goes away, StartConfigurator() should be aborted, no?

Yes, probably not a bad idea.

> 
>> +
>> +            This method behaves nearly the same as ConfigureEnrollee
>> +            except upon receiving an enrollees first exchange
>> +            request the registered agent will be asked for the
>> +            shared code using the RequestSharedCode method.
>> +
>> +            Though the agent can provide shared codes for multiple
>> +            enrollees, this method will only configure a single
>> +            enrollee at a time. Once completed it will need to be
>> +            called again to configure additional enrollees.
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.NotConnected
>> +                        net.connman.iwd.NoAgent
>> +
>> +        void RegisterSharedCodeAgent(object path)
>> +
>> +            Register the agent object for servicing shared code
>> +            requests on the net.connman.iwd.SharedCodeAgent
>> +            interface. There may only be one agent registered at a
>> +            time per SharedCodeDeviceProvisioning interface.
>> +
>> +            Possible Errors:    [service].Error.InvalidArguments
>> +                        [service].Error.AlreadyExists
>> +
>> +        void UnregisterSharedCodeAgent()
>> +
>> +            Unregister an existing agent.
>> +
>> +            Possible Errors:    [service].Error.NotFound
>> +
>> +Properties    boolean Started [readonly]
>> +
>> +            True if shared code device provisioning is currently
>> +            active. (configurator or enrollee is started)
>> +
>> +        string Role [readonly, optional]
>> +
>> +            Indicates the DPP role. Possible values are "enrollee"
>> +            or "configurator". This property is only available when
>> +            Started is true.
>> +
>> +SharedCodeAgent hierarchy
>> +=========================
>> +
>> +Service        unique name
>> +Interface    net.connman.iwd.SharedCodeAgent [Experimental]
>> +Object path    freely definable
>> +
>> +Methods        void Release() [noreply]
>> +
>> +            This method gets called when the service daemon
>> +            unregisters the agent.
> 
> You don't actually call this method.
> 
>> +
>> +        string RequestSharedCode(object network, string identifier)
>> +
>> +            This method gets called when a shared code is requested
>> +            for a particular enrollee, distingushed by the
>> +            identifier. The shared code agent should lookup the
>> +            identifier and return the shared code, or return an
>> +            error if not found.
> 
> Looks like you don't actually call the agent with the network object?

Yeah, this was a mistake, there should just be the one string argument.

> 
>> +
>> +            Possible Errors:    [service].Error.Canceled
>> +                        [service].Error.NotFound
>> +
>> +        void Cancel(string reason) [noreply]
>> +
>> +            This method gets called to indicate that the agent
>> +            request failed before a reply was returned. The
>> +            argument will indicate why the request is being
>> +            cancelled and may be "user-canceled", "timed-out" or
>> +            "shutdown".
> 
> You don't call this method either.
>> +
>> +Examples    Requesting a shared code for an enrollee identified by "foo"
>> +
>> +            RequestSharedCode("foo") ==> "super_secret_code"
> 
> This signature incorrect as well?
> 
> Regards,
> -Denis
