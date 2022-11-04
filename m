Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F688489
	for <iwd@lists.linux.dev>; Fri,  4 Nov 2022 17:54:56 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id r76so5892569oie.13
        for <iwd@lists.linux.dev>; Fri, 04 Nov 2022 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RarhfFSRqOQRMo1yIl4VW9KbfAhqELG+8RSRUIIv/v8=;
        b=P8qNsh94yA1m4giMbzq5/53PVFkxN59gUOW5tj8AS4ujfuYbDoKwyyaoOgZ7FDAMbk
         HrDKuxlP8MZ/Mghvn4ovs5BdmRX0G8DRG3CdaxdQ1WPFi9NYYwCc4185v6sVN/FBDgua
         4En0hL/byPO0TBw4BOWsA3WPMgkRUq1p3kovgpWeR1RsC4f5p34j/yhw+tHY/az8yA3f
         eAADaayv1yR+q7uWFojYJQidk5e2ySXA7R5AoEUel9odcqj99voNjwCp+CHBZULLrNFX
         tZEEoPuusStbH9bppZ7PfEh5hkGBFBvlxu2lJETMRVZgAxJK3G17gHEBAhYh/kpKL23X
         5paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RarhfFSRqOQRMo1yIl4VW9KbfAhqELG+8RSRUIIv/v8=;
        b=E92GOYoQeOHvKIedQMXN6k/F33KEnog0Wqtsd3x/nHAyhw8kJwKEjC5n8iDngSmk6U
         jwncJ2AvDqNVfJ0sCgFuTm05+q8zzMte+nR2BSavp+cBSPU/fSkdBBxUxGwJkrZKZBtX
         pGTvQ7ZJ85wOdjtSUDjlhVQeE4yxivxvtQp89CKF8w/12eUMpXJ3/mKUq+LojmIKXfuE
         4GW5GuXrQ46+/ASGlOrSLhCN8TfDOHmVkyAACRrc5WQphPJo9UfIloigUTmIxTix+XUL
         dw1ZL8YyeLMCq04SE5PUYGqb3oNnBu2o138rNm9ji4rGntyDktnI7ISNZLhYB8YErU64
         WH9g==
X-Gm-Message-State: ACrzQf3fOVdtLefxxUy8ZQmNMgPYzRypnm+qwsDhhdXPSpXL0r/aqt41
	9qZrHly/NFn8cbQtts0EsBNfYeJt0IE=
X-Google-Smtp-Source: AMsMyM6BX75fOtpdRTbwcEgrC2OWMWO+pI+/oq+0O/4X2MbMElBHvmVWpqIWLHnG9KSnmOpOk6fKxA==
X-Received: by 2002:aca:d841:0:b0:35a:5959:590d with SMTP id p62-20020acad841000000b0035a5959590dmr3096835oig.120.1667584495082;
        Fri, 04 Nov 2022 10:54:55 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p186-20020acaf1c3000000b0035437f4deefsm1683911oih.26.2022.11.04.10.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:54:54 -0700 (PDT)
Message-ID: <a23aafdd-896d-7c76-8187-208708988345@gmail.com>
Date: Fri, 4 Nov 2022 12:54:53 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] ap: update Scanning property when AP starts
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221104163800.451867-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221104163800.451867-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/4/22 11:37, James Prestwood wrote:
> This wasn't being updated meaning the property is missing until a
> scan is issued over DBus.
> 
> Rather than duplicate all the property changed calls they were all
> factored out into a helper function.
> ---
>   src/ap.c | 55 +++++++++++++++++++++++++------------------------------
>   1 file changed, 25 insertions(+), 30 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

