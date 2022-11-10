Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615572F23
	for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 15:18:43 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id n205so2142749oib.1
        for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 07:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QD7m/YkdNViG79lyn2X/SRFUYFZml3ei7lvutyVr1iY=;
        b=EEGZrENNeOGDon/mBOXCDLImSfBI9ZKoJXw8+HeRI/cg5P7P75F8mTLfhKrc2uzZlm
         eb/T2Eo7orKm5VMbADOKhZqTFRQqj242FiqlhKlftZBLZG9RSC29TIZ0sIcxokbsVrrD
         h+wzGuGWeHW3cYH3z92xCmBRY2ob21biY1Qwj33A37vtXcXuT73U6Oi69yFv8qlp8/h5
         ZfnSsPYDDVpY/ykjc/6oeQqD/OAFfnx6ylj1zyWVfnlk788nUSVDd1El4uf6j5TK7LjZ
         g5XI0KzwyB2Sf78BwXacGo33AOguHJCVy2Dnq30FWE19jb6LyU61CFuaUR4lo9+j+Tfo
         hbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QD7m/YkdNViG79lyn2X/SRFUYFZml3ei7lvutyVr1iY=;
        b=m4eS9DLNouCJ9vbK9E5okwHGa/BaTouLSbYfRculkeMXIrDEI5uxFcWLb3DjyUHwlJ
         UVLQ2vxS7NWukJoILBeEctwmqDtK49e+D9+zIKrfC31eeClGXlNqT5Gg+baFKN7RYH2B
         3Wb7+1v2mH0XITpeqobCLg2d81itJf2fqb7zfzow004mtoUKVyT8Bm5NJ9KNvM7W3/2v
         ylKqJaN6jXyNC0Y1pgxnIrJmzzv7UaEDJdpewI0Sd5yusayJvLADZ/uVYynWB0QFoSkZ
         nFjMqWqlEwjcrbYSyMWiJyUqB+SdJqovQLcektkve1tagheVql30y99LdHp3SBzyE3aB
         YJeA==
X-Gm-Message-State: ACrzQf2cs1GkYU4ZSgPoeZMnBrGyPyZ23CeLNeig8oBb80RRvHlwJqyX
	tQEzqjTxYTrpXByj1YTO72m7rpvn8v4=
X-Google-Smtp-Source: AMsMyM4JvnV4Id4pcRw/aHOZ+rIC1ItvReC+bkdZElhmafXNpcKm5dJZZBSQa0EW9wN207PDArVEBQ==
X-Received: by 2002:aca:1807:0:b0:35a:7a8:3a26 with SMTP id h7-20020aca1807000000b0035a07a83a26mr1512374oih.27.1668093522292;
        Thu, 10 Nov 2022 07:18:42 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id be17-20020a056808219100b00353ef11d6c9sm5180669oib.19.2022.11.10.07.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 07:18:41 -0800 (PST)
Message-ID: <7931ee49-c4fe-51b2-81c0-afc473c19fda@gmail.com>
Date: Thu, 10 Nov 2022 09:18:40 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] eap-tls: Add session caching
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: iwd@lists.linux.dev
References: <20221109170438.535300-1-andrew.zaborowski@intel.com>
 <20221109170438.535300-2-andrew.zaborowski@intel.com>
 <e7035cb1-17d0-22e5-3bfa-4e6515e2b4c9@gmail.com>
 <CAOq732Lhjow_iZyNHs9bn+j9q_yHsZDP7qX37pgWrzsUs+y=AA@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOq732Lhjow_iZyNHs9bn+j9q_yHsZDP7qX37pgWrzsUs+y=AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

>> But isn't the TLS session ultimately out to the RADIUS server?  So wouldn't the
>> session id be identical between the entire ESS/SSID?
> 
> So like I said it may be but we can't know this.  There may be no
> RADIUS server: looking at 802.1x everytime it mentions RADIUS it's an
> "example" AAA and also mentions Diameter.  But there may be no central
> AAA server in the first place.
> 
> For example 6.3.1 says: "The Authenticator and an Authentication
> Server can be co-located within the same system, allowing that system
> to perform the authentication function without the need for
> communication with an external server. However most port-based network
> access control applications use a separate Authentication Server, to
> allow centralized administration (...) throughout a network.", similar
> wording in other places.
> 

Right.  A centralized RADIUS server is the general case.

> And then multiple ESSes (different SSIDs) can use the same AAA but
> it's the same situation because we can't know for sure (unless the
> BSSID is the same)

Sure, but why even bring this up?  We can't know whether different SSIDs would 
use the same RADIUS server.  But it is pretty much expected that a within an 
ESS, the same RADIUS server is used.

> 
> I think indexing by BSSID should work well but can also change this to
> use just the SSID, or both.

Ultimately I don't see why we would want to limit this to just the BSSID?  Lets 
say you logged into a WPA-Enterprise network on 'AP A'.  You suspend your laptop 
and move within the building.  Resume and re-connect to 'AP B'.  There is a high 
likelihood that AP A & B share the RADIUS server and thus the TLS session.

But even if 'AP B' doesn't share the TLS session, what is the harm in trying? 
Worst case the TLS server will reject our session ID and we'd have to start from 
scratch.

So if we index by
	a) SSID -> there's a good chance that we can reuse the session across routers, 
even if that fails in some cases
	b) SSID + BSS -> We never try the session ID unless we have been connected to 
the same BSS before.  In which case there's no advantage over PMK caching?

<snip>

>> We can't have SSIDs with multiple EAP types.
> 
> I think some of the eduroam networks do support fallback EAP types but
> I guess the TLS cache may be independent of the EAP type.
> 

We also can't use multiple method types within our profile either.

>>
>> This does however bring up another point.  Shouldn't you clear out the cache
>> when a network is forgotten?
> 
> Good point, if we include the SSID as the (or one of) primary keys we
> can drop entries related to that SSID.  Or we could expire old entries
> with time.

I would think we need to explicitly drop anything related to the SSID of the 
network we just removed via KnownNetworks.Forget()

> 
>> In which case, how do you reload the cache in the
>> EAP module?
> 
> We don't need to notify the l_tls instances about the change.  They
> share one l_settings object but they only look at it at one time in
> the handshake and don't assume that the cache is unchanged between
> handshakes.

Yes, but how does eap remove the relevant entries from the cache?

<snip>

>>
>> Can we run into a situation where we have two TLS sessions running with the same
>> cache entry and it is invalidated somehow?  Do we need to notify the other TLS
>> sessions somehow?
>>
>> Perhaps if we're running a multi WLAN setup and both are connected to the same SSID?
> 
> This should be fine, once a new session is ready it's immediately
> added to the cache and other instances can resume the same session
> even while it's active.  The spec says if the session is being
> removed, active instances that use it can keep going, only no new
> resumptions can happen.
> 

Ah, nice.  That makes this not a concern then.

Regards,
-Denis
