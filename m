Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D5374CB
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEq4s6vu"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce322b62aeso3004134a34.3
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698161560; x=1698766360; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6CR3hW9guPSL+YL/tdJY2JCx31XK+imzGPZ6W3df54=;
        b=mEq4s6vuFeAbJMrAmrkHuAknCS6ph+gxOWEXAwJq7M5dzxisMKDNUhTTrBdP3mpN2u
         TMZVYEQ+AbB44O79VMMqCY5IfsW8le2Oh5VQObZoquSe4JSmv8dD1qyXS70pXGq9qdnd
         doMIF4Sk0I/1eNTuB1bRNhYJ8lKTAYEZbzoDTzGV0dJGhHMUuHR2HUg9vVjkULQApKrv
         eCX8mQucYE+IWZNDJF+1Y2wnCbvGHKKHW3/YjRZvxtPH0zyXjulraavXoFv2gmbm4Nj8
         Kg08Pw1+7BIj9UUIGzMUmpLLlRnThHTNZvdXPzUUKZWZiIM/ydaoPz7eoNmyTxpSeplY
         8qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698161560; x=1698766360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6CR3hW9guPSL+YL/tdJY2JCx31XK+imzGPZ6W3df54=;
        b=Bs4TTV6/Bvw/1nAsQfoHl4EVMGA+FAz+cZC88kPkYhJbbCGacBDH5OVQ+UTaNgLN9V
         KyoWni+fu7mrIKPaWO+R985VR1UiTp0VqjkdfVRYTzTfuBtqCzqwXxC6YrXXXnrg6AMQ
         FjjdScdxqsQQwNR9q+YEbNDY+9EGyi3xm5Uf1HxamNFF7vDpGxp13v3SfOaIdDUic6KR
         oK8dRFjwquVEEZwxHmttcHXX465cWEVGfQDz+zvSXDsX3CYymVt6+ErOXmiNjHw0TSYx
         pwaQWSJMNRK0sogGumNEhcH5KmNtHuXCulAJ2KUyDRRUPCvdEO48vlm7XXYF7jTfq4qq
         HWlA==
X-Gm-Message-State: AOJu0YzvHSz81pw5bUNj/fbuwohJutwcq5P7XcmwEzbJiG3sR3AsG1Y6
	japwXhhAzw20Nj2tn9ZNgNU=
X-Google-Smtp-Source: AGHT+IH1iulxve21BYOuGXWwPfYEdbugEkEkLMEHxxvOcp8s9o+sMsN4ADNkwN4Pw2V124Rwrax2oA==
X-Received: by 2002:a05:6830:4117:b0:6cd:8c8:1654 with SMTP id w23-20020a056830411700b006cd08c81654mr16507234ott.2.1698161560567;
        Tue, 24 Oct 2023 08:32:40 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t8-20020a9d66c8000000b006ce2fce83cbsm1901989otm.25.2023.10.24.08.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:32:40 -0700 (PDT)
Message-ID: <1740def7-87b2-4d14-a6b1-c4522b9dcbf1@gmail.com>
Date: Tue, 24 Oct 2023 10:32:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
 <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
 <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
 <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
 <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
 <8a9039e3-1db3-459f-874b-e53d8dcdc16d@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <8a9039e3-1db3-459f-874b-e53d8dcdc16d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>
>> They are not made up, they're direct from 802.11.  But again, they're the 
>> _minimum_ specified sensitivity.  Hardware typically does better.
> 
> The rates/MCS table (ht_vht_rates) is from 802.11, but the mapping from RSSI to 
> MCS index's (ht_vht_he_base_rssi) is not. The spec just has a formula for 
> calculating the rate using a given MCS/channel width. IWD just chooses what it 
> thinks the MCS will be for a given RSSI.

Sheesh!  Everything is directly from 802.11.

80211-2020.pdf, page 2835, Table 17-18.
80211ax-2021.pdf, page 642, Table 27-51

> 
> I don't remember exactly where I got those values from but this seems to match:
> 

The spec?

Regards,
-Denis
