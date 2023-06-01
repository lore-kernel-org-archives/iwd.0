Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ABE23400
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 15:38:06 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5559e296433so776340eaf.0
        for <iwd@lists.linux.dev>; Thu, 01 Jun 2023 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685633886; x=1688225886;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Az9kQgdIC4MzPFWial6ZJT4ngUO/t+TGOKGWL9ynZHw=;
        b=nAQYVJOMwnu5rQ97Mo8Z8uTDqlEruOkhXBRwiweNGWUlxi6VtwmKUPNOGcnS3m74Dh
         wnDLwpLCsd0ZOz13fiL3f4K1gRHx58rP6BubPCXcrzJ1HDiXuzsIFlvKvc2/Ncy8rlTL
         ITqBlyxQxk/ID6yOb+909kXYXfDlCGaFrLZsloK2WDNbzRXYLnnBOFfHnsREVal90YAS
         QyrSdiK10CWQFtu/Ehk2BQgZoXw35pgM81LLOBlhV/b6rzp7Ue1UPm7+WyuMLdzkE+LA
         CbgBxC9WrYAGda/R7Wzgkjprf/WNOui/OkKo9ZerFUUhJnTa1lTrr53ysUSsz/+55sZp
         1Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685633886; x=1688225886;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Az9kQgdIC4MzPFWial6ZJT4ngUO/t+TGOKGWL9ynZHw=;
        b=WuqENASQnVLUSsPFJ6x2GnXOkMbVH30GCHDCbrbv6zMkfKxioG6w97kg9XOqm3+pQ/
         JHnkuSkW/g3C6ZS4TVCP6W+8vAtU+PmzmCvepCzAZEik8bY0wLCh3G4rtiD/9euRajSO
         4WTfczqLSd5shtT33MUYk8TyUwvNqVR/qAmn8hdAHlIWNw0xEX3NIza+BLcSN7iwQBWv
         pShqqr0dXb+ARoER9Dvwi/TCTZ5Hw347PhAmLfN6YUoK3WReI75JbKLcm5Y4u+e9hrrZ
         a6eiQ0+d/IqSzLrftQRof084RG31Z0d48dlVix25wmGDwvdXkiD8vLHxHfekC1UCtunv
         G5mg==
X-Gm-Message-State: AC+VfDzW+yE1NLXdyHcusFhZBYMLwlDDQxosirZJ3PzJadZyDkq1XujN
	7rEtY9eD15cz22k23NS4fVM=
X-Google-Smtp-Source: ACHHUZ49JlAIyd3pQcdpCold/X5mfDgfjwK4rSArBgp0kqK3mighs0f5gIPQwuCaUIV+K/4Cfq1xOQ==
X-Received: by 2002:a05:6820:1a84:b0:541:87fe:5b75 with SMTP id bt4-20020a0568201a8400b0054187fe5b75mr1000595oob.1.1685633886031;
        Thu, 01 Jun 2023 08:38:06 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r2-20020a4aea82000000b00552502f3ae1sm7310178ooh.39.2023.06.01.08.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:38:05 -0700 (PDT)
Message-ID: <3100d4e1-e20e-dbd8-4471-6add0224d1fc@gmail.com>
Date: Thu, 1 Jun 2023 10:38:04 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: issue using virtual interface with iwd
Content-Language: en-US
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/1/23 08:17, Michael John wrote:
> Hello,
> 
> I'm having an issue getting iwd to recognize a virtual interface.
> Using 'iw' I've created a virtual interface called wlan1:
> 
> iw dev wlan0 interface add wlan1 type __ap
> 

Are you doing this before or after starting iwd?  Right now iwd ignores any 
interfaces created after iwd has detected a phy.  This allows one to create 
interfaces on the fly and start hostapd on them.

If you want iwd to manage all interfaces, pre-create them prior to starting iwd 
(and use the --interfaces command line argument)

iwd only supports STA+P2P combination at the moment.  You could add 
functionality to have iwd create STA+AP interfaces, similar to how we handle P2P 
today (see src/manager.c manager_create_interfaces() or so.) Perhaps based on 
some main.conf setting?  Patches are always welcome.

Regards,
-Denis
