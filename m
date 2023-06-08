Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55839C2DA
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 14:35:07 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b039168ba0so4951305ad.3
        for <iwd@lists.linux.dev>; Thu, 08 Jun 2023 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686234906; x=1688826906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2f5mYWQVXk3UGQ78fKT2Heqa7Btq++h81X+OEhduLk=;
        b=rGIQ6uQgeF8k7o3HRb6NVxYarHMFWGeB3gY1R27f3zy4PEzMyvEzGhmQCoQdWlpTAh
         6nja8/3u2qv4XA5yGTYgtTBsGWD6OKx86NEM4EPesBJ6fpSg4uF/UN0z+jQ9W9YF/r53
         cswCiElIqexbe2S3s0FpskKakdDlJ6h6ZdPmOi/Gbuz3eR8F9zpN8GwKoFEJqUayQ3O+
         20AC/PzovnZF3l6jETQyYMTVANQu7AQVX4pRXqjZqDCziFm6+mRFAxi1PuQFQSQ/znyo
         VRQbKr4NwZB9XtEcNq3ahXWB5831fuYg4ax6VBjHR1msMxw6g7zJRLsX1rWGKuolU9fa
         mbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234906; x=1688826906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2f5mYWQVXk3UGQ78fKT2Heqa7Btq++h81X+OEhduLk=;
        b=kt9tKXvElXXG9JUErs7kSnL6odju/r35CyMAS55k8f5ODV8YB7y3Rn01twJk6IJWh+
         g5PTGewDd0u6gnhPMKySiS2M7Ls2tDu88N7OxlxrOBrOZ6vVWY9t4EdiJ+Bcuifzbi3Z
         V5yn/zhHJAdF9LQkfiD8gfqmWZiea/KoeHc0l1k9zuPvXPZ3lgTPUk2iuB5X4Ikk7BjW
         1tMDw8Wl9LZrw2dvQuGUGN5uanoKIT+yc0efzYinuicUQPgtlUCxtOh1SbGt0f4V81m0
         RL4vNVctkANmlWkjdbOCl3P2Iz3w/XIYX/JRdLkY4la/2pUuXKzjfVMyiqqYGKeQyqts
         Ekmg==
X-Gm-Message-State: AC+VfDywjKOPCCRtUAbxCKFdFMlA+3Ixoc6l3no4TwnvmMn7TZWAmqKR
	AmGYr9Jpf7x16P7c0QLWW9qQAdVqOY8=
X-Google-Smtp-Source: ACHHUZ40ySGWfDahlbvErEeRqJgPpooHyYGh+rVSt+e1uj+p2ejvoF8MMLjxLbfiSFjMlSK3tWvHSw==
X-Received: by 2002:a17:902:bcc1:b0:1b1:ced7:2c00 with SMTP id o1-20020a170902bcc100b001b1ced72c00mr8273019pls.19.1686234906499;
        Thu, 08 Jun 2023 07:35:06 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902778800b001ac2c3e436asm1519086pll.186.2023.06.08.07.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 07:35:06 -0700 (PDT)
Message-ID: <826c0918-84ee-649d-2f4c-10c99e0e45a2@gmail.com>
Date: Thu, 8 Jun 2023 07:35:05 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Bring up of AP fails on certain channels
Content-Language: en-US
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB7220600D62E8C2FD1334253FAE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BY3PR08MB7220600D62E8C2FD1334253FAE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/8/23 7:01 AM, Michael John wrote:
> Hello,
> 
> I'm trying to bring up an AP and ran into an issue where iwd
> will fail to do so. My AP profile is below and I'm trying
> to bring up the AP on channel 64 but iwd gives a failure.
> If I change the channel to 6 iwd is able to successfully
> able to bring the AP up. I'm curious to why it fails
> if the channel is 64? The reason I needed channel 64
> is because my radio requires the AP to be on the same
> channel as the STA when in AP+STA mode, and me test
> network  for the STA is on channel 64.
> 
> 
> ~> cat /var/lib/iwd/ap/470034.ap
> [Security]
> Passphrase=myphrase
> PairwiseCiphers=CCMP
> 
> [General]
> DisableHT=true
> Channel=64
> 
> [IPv4]
> Address=10.42.0.1
> Netmask=255.255.255.0
> Gateway=10.42.0.255
> DNS=10.42.0.0
> IPRange=10.42.0.50,10.42.0.60
> 
> 
> ~> iwctl ap wlan1 start-profile 470034
> Argument type is wrong
> 
> ~> iw dev
> phy#0
>          Interface wlan1
>                  ifindex 6
>                  wdev 0x3
>                  addr c0:ee:40:64:4a:1d
>                  type AP
>                  txpower 23.00 dBm
>          Interface wlan0
>                  ifindex 5
>                  wdev 0x2
>                  addr c0:ee:40:64:4a:1c
>                  type managed
>                  txpower 23.00 dBm
> 
> 
> ~> journalctl --no-pager -u iwd --since -1m
> -- Logs begin at Thu 2023-06-08 12:39:15 UTC, end at Thu 2023-06-08 12:55:04 UTC. --
> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent register called
> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent :1.193 path /agent/2814
> Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_validate_band_channel() AP using frequency 5320 and channel width 20MHz (no-HT)
> Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_get_gateway4_mac_cb() Error: Operation not supported (95)
> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 0000: -114
> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 0020: -114
> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 0040: -114
> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00a0: -114
> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00b0: -114
> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00c0: -114
> Jun 08 12:55:00 V2470034 iwd[1229]: START_AP failed: -22
> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_disconnect() agent :1.193 disconnected
> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_free() agent free 0x1d57d18

One thing to note about AP mode on 5GHz is there are many more legal 
restrictions. You can check if 5320mhz (channel 64) has any restrictions 
and look for the frequencies section:

$ iw list

Frequencies:
     * 5320 MHz [64] (22.0 dBm) (no IR, radar detection)

For example in my case "no IR" means I cannot emit any radiation, which 
prevents AP mode from working. It all depends on your hardware, but 
sometimes you can simply set the regulatory domain to unlock those 
frequencies. IWD can do this:

# file: main.conf
[General]
Country=<CC>

Or you can use:
$ iw reg set <CC>

But in my case I'm using a 'self-managed' device (iwlwifi) which doesn't 
allow setting the regulatory domain. For me, I would need to scan as an 
AP first to get the regdom set, but IWD does not currently support this.

Thanks,
James
> 
> Thanks,
> Michael
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
> 
