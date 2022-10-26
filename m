Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601248472
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 19:54:28 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13bd2aea61bso10877053fac.0
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxqgNmwVG0jfhdjW7MPg2HGyGl7TX2hx2T37pageDWg=;
        b=bSpmh1pmYdVntlRKHjesb5UIurLWiZcTP6MCbU1rG0PXJi7biIBpUpYThd6Jp3Fq5N
         +KoV6kACC+z7BCSyh68ZpPMbcfRc5Go3c+Ewryjoop6wLncb0EBgvylZ35s52rBoSEc0
         MFAYiIXlnrdD91nyAMkxQhiyt7RWyzHO0liOchMz75TSU6QRNvKe78hsoWVHiLn5fANT
         VHoDsxHTtGLi8IWiCD2PCxr4I8yOKu8oTLGQK079N1P9cQAQGn7NLRnPzdd4wioB8zK8
         Yf2mwhmbI2413Nv3hKxMUAKF9LJJ90gPk9ce0RvNROf8df773n6kaR+Adr+yQFmoWUfo
         gKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxqgNmwVG0jfhdjW7MPg2HGyGl7TX2hx2T37pageDWg=;
        b=adIE83paY5mBAuqKK9lsCdmhNqSWysVOnIQaCuls0n9XOS/RtvU/c0A2WC2sbbBHWl
         ZE+/9UF2lnOtgn4nIlvp6nXSbKh6sZ3e6LjYhzAH3d5AC3M4hi1t2JXTBkaDqEg3nDnE
         sn1vi/YFYBrKvH3Lde4YTzvIHOyfh4mIF9iZeEi9xEWmV94ITXEbmtShZejloJCxpxm2
         kbMRvLr/rovZGWAf14/VQySso0kGniuanknLNSYdcKA/4H35DfDO3CyvwK+WW9OpJbyH
         B1DH/BT8AQX8SLUIYx29HVTye2gjJ0Iw0Ex5kwvdO7cs7sr1GX+dbUuwgnyNvT1QZKSQ
         nzFA==
X-Gm-Message-State: ACrzQf0gvGZes1+C+d3G6JveLIQNj5XKpQ9O0fBPhPkVmuY1kwazNFyk
	VLqIcOOA2eJKbpAS7bf36mM=
X-Google-Smtp-Source: AMsMyM4W9hM9ttDBU6dK+7p2EqNgADw0cUWwPShASijL3POaQb7Yz4sYcnkSIuJtJpG5iHA4ntc22A==
X-Received: by 2002:a05:6870:a10f:b0:13b:6c61:2297 with SMTP id m15-20020a056870a10f00b0013b6c612297mr3274486oae.31.1666814067461;
        Wed, 26 Oct 2022 12:54:27 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x18-20020a056870331200b00127d2005ea1sm3555147oae.18.2022.10.26.12.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:54:26 -0700 (PDT)
Message-ID: <618160aa-f754-1273-a925-cbc837e797bd@gmail.com>
Date: Wed, 26 Oct 2022 14:54:24 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] netconfig: Print addresses added and removed to debug log
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20221026175828.2435994-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221026175828.2435994-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 10/26/22 12:58, Andrew Zaborowski wrote:
> ---
>   src/netconfig-commit.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

