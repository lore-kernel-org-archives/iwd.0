Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4D182D1
	for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 14:14:35 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a36b309524so723710b6e.3
        for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689257674; x=1691849674;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0U80OUl0mqBYxgXopRvEVOG+rdDk6FIXhu/s/5fIo1Q=;
        b=QV4FJEnuoX9SbwkfJnRxC8flBJCGl403fhXTUy6GEITzYDnnLqV/Xaqr2rfVxA60Ym
         2WKRtkKhfkPKa7BzDJHYdmQuS3foX2N6uxVWCyWD3xL4OCAu9aaVrrKii91mHiwmMask
         Rgl1TqVn3EOVwza/arR+EyKvhrGqM+lwkVIfSGaUEVoAQMtD4TDxZaiIKvGtFKk18uiA
         g8FUxNz6X7VcC/exvlVtVsGHiMvjxT2dYMcnyb+fvigig0BJDwxy/e5RSCZZfTph8SVx
         f6x9JDNFApmfgbl1po1hUxATAvSoWFd6pe319L6OIrVMlILKEinXuJ1rRg2t8lwWZ2Y5
         4elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257674; x=1691849674;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0U80OUl0mqBYxgXopRvEVOG+rdDk6FIXhu/s/5fIo1Q=;
        b=AwJAhXHvxsoLjp1boBdjFhYrdx1HMEbRqovYhIZRzzxXtFwCywhwrzxc1RX7A4c20N
         B9ptEJTRDqjimjQN7NWcFjr8bRMCK0BgCXcLV3qPFelxKDGtUZNs78+xlwdLB6i+dh8B
         KQAx+oF0RsJBqCZIfHtPxE3B+NwvFt5PDYngbSS64uI5VLAuH/aYh4oiqd6gwj6qJW3l
         Am29744Wlr4VI/xdESC+5IW1N0006FBDWxrAuyt1IB2U81UWd7chdKYRgnENX8BxrNK6
         maEFK/daTdxo6EI7F5To3rDanTcniSQlnktr9S8f+AhrEkALiIeqJxw0ImDl53XDvjB2
         wW3Q==
X-Gm-Message-State: ABy/qLae7gwWuL6XmTD0ggRt5Dg8jCe2Vzujh2im3Mo/AHtWtE49qQQz
	jZbcqUO7w54GKc4aAmYUvrM=
X-Google-Smtp-Source: APBJJlHJCzONZS4V81t5Re9swTT8Re83BMDQj72pg0QLw5bTYZyqjZEo6T6xXgqtyqn5nV+v6F8lrA==
X-Received: by 2002:aca:db85:0:b0:3a1:c820:5944 with SMTP id s127-20020acadb85000000b003a1c8205944mr2109131oig.45.1689257674099;
        Thu, 13 Jul 2023 07:14:34 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k2-20020a544702000000b003a422b6ff4csm2042483oik.49.2023.07.13.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:14:33 -0700 (PDT)
Message-ID: <4c290b7e-4ab9-a89c-ba93-50f09bff8be7@gmail.com>
Date: Thu, 13 Jul 2023 09:14:31 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, Wen Gong <quic_wgong@quicinc.com>,
 iwd@lists.01.org, iwd@lists.linux.dev
References: <20210903193544.13897-3-prestwoj@gmail.com>
 <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
 <411c867b-f830-c66c-4c21-f59200993b2a@gmail.com>
 <00246aa8-fe45-f5c2-cf2a-3450cee414f2@quicinc.com>
 <d2a490cf-ae06-ed26-33eb-5475616bd725@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <d2a490cf-ae06-ed26-33eb-5475616bd725@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> Is relaxing the RSNE check in the associate response (for OWE only) something 
> you'd be ok with? Obviously with an L_WARN_ON/l_warn message.
> 

Yes, definitely.  This is our standard operating procedure, stick to the spec 
unless we see an interoperability issue.

Regards,
-Denis

