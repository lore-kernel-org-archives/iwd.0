Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FF2106B
	for <iwd@lists.linux.dev>; Fri, 26 May 2023 14:12:16 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so749894b3a.3
        for <iwd@lists.linux.dev>; Fri, 26 May 2023 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685110336; x=1687702336;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPne71MCH/DM7BeS7MeTIcjbxv+Seq3vS7PawL69IkI=;
        b=YqBo6FmBY8PYgRhumEwf00po5k0sC98O7m61IolqOQrJMqA1texuDJgeX+2Q3dGfJS
         Si8nRniTrhOSC+B82wyePEs12CmOANw98ObBLujL5bOrPzghnspRH3oAtaOOPnOJQWEx
         78doMgFX0Lrbezk6dyZw3DRMQoA1B0XrErlybAJXRiqyJBJqSvMiihfVWCrXMmkIzO/W
         Hs0G7pg66HXBGaRUrHUYfX7abxWTUCwrogFh2n+4mOvZyBvyYitVWWETcVXa488pZstP
         P5tPy6IQqNiGI2xyjOVpPQ2+l6wu4C1y3m5Jjny+PvEcLWZKVVijUEHQevoC8KZu2MWy
         vFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685110336; x=1687702336;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPne71MCH/DM7BeS7MeTIcjbxv+Seq3vS7PawL69IkI=;
        b=B39HDL/eLb0K/NvU7ZzoyNP0Ghh5Ly6tGdUETfoiN+2MwZgRrIuXs2WmTQH0PCNJ+b
         SoybkC3PZcGWG17qtJ6xzho4kYojMGGh5nLkX1JNbZa7NS9MiqHaG1U+xYWbc9YN5K/5
         p4Yln68gvkGAxYAN2pNuSFPolvomLslZhKNijKgI5RSUoSoJCmCkstyV0PNieghgbbPM
         ECWyS3oJSfRvoDvwkehqtgB3BzaTqgjGN74TPaHuGX0Q/6TcLY41mKMMHK2Wk8ct3mEm
         gbcxBl5InLyg96QZQVx/c6JsGLzoISm2Hmbs9P6yf36idmIi4dbbv8LH1/XuFCevWyI/
         m0VA==
X-Gm-Message-State: AC+VfDwr1p0SgH9P1PUhEdWhc3mvnnmTIBqgSnEBPpQPgU0OoqGMmVu+
	a7JJMXjjRtc9SVrLCQCsMmg=
X-Google-Smtp-Source: ACHHUZ4IVnu+11MM7Telp76WcDIwysTDqGJLbSnoA/sLxFnChl2Moj6/k+lNWDFoG4eZX7XRJ8qDrg==
X-Received: by 2002:a17:902:d381:b0:19f:3797:d8de with SMTP id e1-20020a170902d38100b0019f3797d8demr2671098pld.9.1685110336055;
        Fri, 26 May 2023 07:12:16 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902b68200b001aaf2e7b06csm3299909pls.132.2023.05.26.07.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 07:12:15 -0700 (PDT)
Message-ID: <951f5c65-7648-ea55-6eed-feaa615bc7f5@gmail.com>
Date: Fri, 26 May 2023 07:12:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: wifi disconnects periodically
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_Nrg_PCVFR1UZLROME+TuKy5_3N=JgfBkLF2cpZaiaTVw@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_Nrg_PCVFR1UZLROME+TuKy5_3N=JgfBkLF2cpZaiaTVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 5/26/23 5:56 AM, KeithG wrote:
> I recently changed from Arch Linux on my Pis to now using RaspiOS
> bullseye. I have noticed that, periodically, I get a disconnect from
> my AP. I am not completely certain that this is it, but the journal
> shows this at the time I think it lost connection:
> 
> May 26 07:23:47 kitchenrune dbus-daemon[308]: [system] Activating via
> systemd: service name='org.freedesktop.timedate1'
> unit='dbus-org.freedesktop.timedate1.service' requested by ':1.49134'>
> May 26 07:23:47 kitchenrune systemd[1]: Starting Time & Date Service...
> May 26 07:23:48 kitchenrune dbus-daemon[308]: [system] Successfully
> activated service 'org.freedesktop.timedate1'
> May 26 07:23:48 kitchenrune systemd[1]: Started Time & Date Service.
> May 26 07:23:48 kitchenrune systemd-resolved[13100]: Failed to emit
> notification about changed property CurrentDNSServer: Transport
> endpoint is not connected
> May 26 07:23:48 kitchenrune systemd[1]: Stopping Network Name Resolution...
> May 26 07:23:48 kitchenrune systemd[1]: systemd-resolved.service: Succeeded.
> May 26 07:23:48 kitchenrune systemd[1]: Stopped Network Name Resolution.
> May 26 07:23:48 kitchenrune systemd[1]: Starting Network Name Resolution...
> May 26 07:23:48 kitchenrune systemd-resolved[17192]: Positive Trust Anchors:
> May 26 07:23:48 kitchenrune systemd-resolved[17192]: . IN DS 20326 8 2
> e06d44b80b8f1d39a95c0b0d7c65d08458e880409bbc683457104237c7f8ec8d
> May 26 07:23:48 kitchenrune systemd-resolved[17192]: Negative trust
> anchors: 10.in-addr.arpa 16.172.in-addr.arpa 17.172.in-addr.arpa
> 18.172.in-addr.arpa 19.172.in-addr.arpa 20.172.in-addr.a>
> May 26 07:23:48 kitchenrune systemd-resolved[17192]: Using system
> hostname 'kitchenrune'.
> May 26 07:23:48 kitchenrune systemd[1]: Started Network Name Resolution.
> May 26 07:24:18 kitchenrune systemd[1]: systemd-timedated.service: Succeeded.
> May 26 07:25:44 kitchenrune iwd[313]: wiphy_estimate_data_rate() failed
> May 26 07:25:44 kitchenrune iwd[313]: wiphy_estimate_data_rate() failed
> May 26 07:25:44 kitchenrune iwd[313]: wiphy_estimate_data_rate() failed
> May 26 07:28:01 kitchenrune kernel: nfs: server 192.168.2.253 not
> responding, timed out
> (and I cannot connect to my NFS share)
> 
> I am running a custom built iwd version 2.4 and ell 0.56 with custom
> built connman 1.41
> 
> What was going on when it lost connection:
> I was listening to an internet stream and it stopped playing. When it
> did, I was no longer able to ping nor ssh into the pi. I was able to
> get it to reconnect to my local LAN by restarting the AP radio on the
> router.
> 
> I am not aware of this happening like this before. Any ideas on what I
> can check?

Its hard to say, there isn't much to go on here. I'd suggest running IWD 
in debug mode and seeing if we can get any more info from that.

If your using IWD for DHCP you might also start IWD with 
IWD_DHCP_DEBUG=debug set in case its got something to do with a DHCP renew.

Thanks,
James

> 
> Keith
> 
