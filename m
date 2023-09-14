Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D789FC1C
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 18:33:31 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58c92a2c52dso14292807b3.2
        for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694716410; x=1695321210; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuNriDIWPvKoDHzpLyvRIjxCAdAk8Q/TapUl/KuHRHM=;
        b=M5cX+6vfc6raIZjTCMyGK1VHUBYQBQv8fSFoSzPiZO/mPgMcb6wS/WH881++m4yK9t
         ytwRShuiOAzQHtfXGCivsTKO8qFeSUwT6ioh0hdq9JhdWcFoJy+ogm/ugoxScbBMFCmt
         ISZ4IywdIeMmX7ZkSPV3vPqbDEmdlkY5tc0NGI/T2u4NMQBdqI7OgpLQy/kfQxuFybzE
         KNDIz8+pbFIhp5YtDhZBUtjVIATB9z1yyVGWn/hxrgqjp9V5Gfh/Oqnp39SJpgppO0hS
         mNFnLesdQiFp/3vnkMVMwijlbzM4Ave2vGMj6Lbhv9jSwvrejIH3/R0iXODGNN5maXY3
         qFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716410; x=1695321210;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuNriDIWPvKoDHzpLyvRIjxCAdAk8Q/TapUl/KuHRHM=;
        b=Ck5Er4fYfUF30ON7vf65xpnkYuNADMLyqZQJEo2KH3q56OhgPYs27aOnmWjIblbnGe
         fKgsmkTuel9aoZYgLIi2p0A2cvCmmKCm5xwwT/XgOqhEXoH4psSAxaSoTlkNGYApKzod
         v3WfrOBr/tjOzhlPgIQoK1ewMpCbxW0/Mol8Rj3TbhBzs7xySstd1pyoZJEiGpZk4MNe
         QW9Zu7eY2/m2udo9yzKFrtbMZcxTMBNSlaRjgVBM13jdXxWVuTCPQYzkFQP6reCJwODc
         6nfBA9pdRGZm43VQpnI5VIGC/AybKCKZcH53pvvQhYvXFXo26hAIU1G0Fh3Wp+XiEPWr
         p8lQ==
X-Gm-Message-State: AOJu0YxIfI97HTr9a17ayqcthbdheeHiIiXv+SKuuUrn/FbAFaZrWcUE
	4i88O0/RSGw5768mehe+uPkCC7LdAMI=
X-Google-Smtp-Source: AGHT+IEVG2VtnH2M4JGg7WOHaIOIMLk+OwxtbEMiK183i+H6fneWA/qQjRg/mlJd0duKxf1R/k1NdQ==
X-Received: by 2002:a81:6e09:0:b0:56c:f32d:1753 with SMTP id j9-20020a816e09000000b0056cf32d1753mr6062188ywc.44.1694716410149;
        Thu, 14 Sep 2023 11:33:30 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z67-20020a0dd746000000b0058e430889d5sm457139ywd.10.2023.09.14.11.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:33:29 -0700 (PDT)
Message-ID: <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
Date: Thu, 14 Sep 2023 11:33:27 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: =?UTF-8?Q?Jonas_Gro=C3=9Fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/14/23 11:22 AM, Jonas Große Sundrup wrote:
> On Thu, 2023-09-14 at 11:16 -0700, James Prestwood wrote:
>> Yep that would do it.
> 
> automatically quick scan upon start: https://p.nnev.de/12646
> 
> explicit scan triggered via "station wifi scan":
> https://p.nnev.de/12647
> 
> anything insightful in there?

A value of 1000 should definitely work... Are you sure the syntax is 
right inside main.conf:

[Rank]
BandModifier5Ghz=1000

(I noticed in your original email you had the 'h' capitalized in 5Ghz)

> 
> 
> Thanks,
> Jonas
