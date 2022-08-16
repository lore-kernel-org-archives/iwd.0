Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC01104
	for <iwd@lists.linux.dev>; Tue, 16 Aug 2022 20:42:51 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so8180643otd.12
        for <iwd@lists.linux.dev>; Tue, 16 Aug 2022 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4iwayhSn28c0eZfLsRiyR/5CwGkUUxbnj6XGFoF/Fq4=;
        b=bbA+MyobgE+vX/I2xuwc3a++LJL1sC0tyI4b8ASmYjBR16TeJ1k3f5jMLU+FIz83I/
         KY0bKmkWkWZnKAfSM6tvy30m9ZK8u9C3yPQAmem0R5K6YNocpIQ8Cr9W/Mssj6J/PF9U
         h3PRhdvV/Bjh1vhmXOCVZk/qtoEejYiMR1tO02qvxv32r+3ISxVLEfWoqkfRus0gHQ6t
         GgfdGNoGBTYyqw2dub2G+18oEQGQcbBFBJLDAjvJzLZqBW6MXXyOAIsi8ZSDCkx76eHr
         DUvKggD7GbWam+FXJ+evU4rdEdDcmddHM31VYBEFZOr8O7jsZ6M+jM3wjoyaQWHeiBcK
         l3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4iwayhSn28c0eZfLsRiyR/5CwGkUUxbnj6XGFoF/Fq4=;
        b=YKNC5YoAloMuTfDoUrGA2UHYIDOSU7mVrYofGmoVDQOZOGnS+w5i6Bd8ageQtOS0zd
         QIxyVILMYq3VV/nd7Hl2XSxuXqS57t8maNEkqFuC22FOBvUT+R5OTh4wqc/TQgQ99zyv
         sa0klA4gLAhXuCNyQ8i2B/Ppx0W0xDTgYBnzPfh71iN29LPGJixHsfWBZYDf1tbgwKJG
         biJ8a5ITkLCN61iJIKA9ftj9xhC/QdxpcjSDA+r+mZuk5fNAFhkZT0zdS5IKpyK76Lh0
         3tKC0GiX/ADFJba4kXp/5NFBbfjlvgu6sCodL5MbgslRVtHw7IN6tSnZRKEvsREx9nrf
         eRqw==
X-Gm-Message-State: ACgBeo1Cb14Q/SzDFRrpuuFj/JD4c9w1mtj5lpNbxseExYDeumTLiapi
	tkRNHxVimlPZdto2lIvpJ+sVgExEqgY=
X-Google-Smtp-Source: AA6agR4KxCXa+AfAl0p+2mLIw3KMdOiVZ6yNFP/k9nEbBabdfXVBDmslNsgJb7juwls4yH/vkB54Pg==
X-Received: by 2002:a9d:2dc9:0:b0:638:a55c:a891 with SMTP id g67-20020a9d2dc9000000b00638a55ca891mr4201371otb.81.1660682570492;
        Tue, 16 Aug 2022 13:42:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r131-20020acaf389000000b00344eb5a9416sm360943oih.55.2022.08.16.13.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 13:42:50 -0700 (PDT)
Message-ID: <56a12204-5d4b-6c0a-6b87-f6faf4296408@gmail.com>
Date: Tue, 16 Aug 2022 15:31:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 0/4] Roam based on packet loss event
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: mjohnson459@gmail.com
References: <20220809230428.215970-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220809230428.215970-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/9/22 18:04, James Prestwood wrote:
> A few weeks ago a user (CC'ed) reported that his driver was not roaming
> as expected, and would get disconnected before any CQM RSSI events got
> to userspace. He did see that the kernel was sending packet loss events
> which should also be a good reason to roam.
> 
> These patches do just that, roam based on packet loss events.
> 
> Sending as an RFC so Michael can (hopefully) give this a trial run. I
> can simulate packet loss events in a virtual environment, but testing
> on the driver in question would be best.
> 

I went ahead and applied this series.  Hopefully the default packet loss 
threshold is good enough.  Worst case we might have to make it configurable or 
disable it on certain drivers.

Regards,
-Denis
