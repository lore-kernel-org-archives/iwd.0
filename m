Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D8A56
	for <iwd@lists.linux.dev>; Thu,  6 Jul 2023 03:05:15 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso514765ab.2
        for <iwd@lists.linux.dev>; Wed, 05 Jul 2023 20:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688612714; x=1691204714;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmHOHprQdNg4P7IhRiUl5LQlAtmQwDUscyGdLpJMy6g=;
        b=oI8QNHgze1NuKhNPAa/SWGjKCXXOikB8QoY72wR/gnERCFmz3d4YAkHvt46OaiEpvg
         d7h8G9TFxCSzf9QZRcuNNbqdwBsAH76P2lG3Z0AM4tep0Ml4Wx/1NenWQgwSDUNwfG+U
         vIbcv3XaBvbZIR+ePFSvXEi3tKf7L61hMNpArELjaXj7AlR/CgTSTKunx9iBbhKO/lj2
         G1Me5Vtab2c8VnU2wAsNDi5rLDZFHpkF/ILkM/mKzQ/UodS5cGQzdPy9L0r6iGI2fo4n
         nGcibUs6JadbJEP4mK5AsflQbkzEmatPPyWy/d1lwDTkNLHtrxxixRzvuLR7G+DtJVPs
         ZawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688612714; x=1691204714;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmHOHprQdNg4P7IhRiUl5LQlAtmQwDUscyGdLpJMy6g=;
        b=gSolMTZtVxQ/8mw1ZOOqSj5rc3TtrLwlttneYjG7hAB77HXvnns4xckdOahxtkoa6q
         lbICbZ7aAhvjjfz6PproGHZbOtGkyCwz//S9V/tKSL+M/dKAfNZYf2BHKgECoqMIRFxi
         qbktAqP8ZNMoZGZMEzSebfZKjJNGrzN08gxe5KrXZDafC3662tFpF80lmbgi9vKkFTBo
         jX1WQBpKlIImUqPU9oAVe4rW3W4mGfIjvcmCZkBs4fMEo3a51FfW3b2ddiIYwCgpdBrl
         nds05a2aOP/dQhQlKwLSQYzlLDUR7cIeDtkM+hLp+f0nIK27b6ncB9N6ESouu32XGbP8
         cgDQ==
X-Gm-Message-State: ABy/qLZVKxxkytWALKJXDMx0yF0MFgjk+z/7w4B3gkisNYwTEHZYDKBX
	aqY7oh+t1kkFT84mTdmPbrd2GY8dnQU=
X-Google-Smtp-Source: APBJJlHdLqTunK5ha87NEE0N+uJbEUn0+Wt7h9XsUwlvUUd096tVzI2vgw267gB8OBiYqtipUQYbYA==
X-Received: by 2002:a92:d9cb:0:b0:346:24c2:4f87 with SMTP id n11-20020a92d9cb000000b0034624c24f87mr828385ilq.32.1688612714467;
        Wed, 05 Jul 2023 20:05:14 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id n18-20020a056e0208f200b003426356a35asm186395ilt.0.2023.07.05.20.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 20:05:14 -0700 (PDT)
Message-ID: <b4a440d1-7c3f-c677-e4e2-8024f6804a87@gmail.com>
Date: Wed, 5 Jul 2023 22:05:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] hwsim: handle ADD/DEL_MAC_ADDR events
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230628202033.2320994-1-prestwoj@gmail.com>
 <20230628202033.2320994-4-prestwoj@gmail.com>
 <ecd84c5a-1be2-8d9e-4bad-da4e3c477e7d@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ecd84c5a-1be2-8d9e-4bad-da4e3c477e7d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> +        __atomic_fetch_add(&interface_rec->ref, 1, __ATOMIC_SEQ_CST);
>> +        memcpy(interface_rec->addr, rx, ETH_ALEN);
> 
> Just realized this memcpy is redundant since the interface_rec wouldn't match 
> unless the address was already the same. This case only happens when 
> randomization is off and is a consequence of the kernel having two separate 
> addresses (one prefixed with 0x4, still not sure why they do this). So you get 
> the following events (say the perm address is 02:00:00:00:00:00):
> 
> ADD(tx=42:00:00:00:00:00, rx=02:00:00:00:00:00) (Interface Creation)
> ADD(tx=42:00:00:00:00:00, rx=02:00:00:00:00:00) (Scanning started)
> DEL(tx=42:00:00:00:00:00, rx=02:00:00:00:00:00) (Scanning ended)
> 
> When scan randomization is enabled it will create a completely separate dummy 
> interface and the DEL event can freely delete that.
> 
> I can remove this in v2 if you have additional comments
> 

Ok, I amended the patch to remove the redundant memcpy and applied.  Please 
double check that I didn't screw anything up.

Regards,
-Denis

