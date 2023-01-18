Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078098C06
	for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 21:59:30 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id j130so190042oif.4
        for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 13:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pt4k63ARZH4VYNlT3cwJCJdLJgk+nK7Brn5hTSlms6c=;
        b=Hf7S+8pFrietjHCgAsyPXIhkzMbIs+gpLCNzzGkWgJNgFO714wtr+ze0kkCWKjOBy+
         ecp+519f6cwM1xe4L1M32Pc5mPYiFxbwtgvxA6KUveWlnmkiAlTdIKesTZCSr1dwxryR
         MHWxkDVy3u+oo6ps+N1qPY3SGllC56knfPPtbuyYCqbouQg2aF/dqrY6Ugn3Dtl/auzc
         0GNu3N+ONcGsIVc5lX0nRANNbPpWtyWO099orD4FxYNPiXDXDxjBBrr5vWjJnOo1PUn/
         vZ8FJ+Oz6Ze8EdOOPWTO4LA05LWlj54c07v55j+wx94jidi1caVsPr2YLE1p1WbbeCm7
         bJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pt4k63ARZH4VYNlT3cwJCJdLJgk+nK7Brn5hTSlms6c=;
        b=BroscP3JIusk1rx2I+UQP/dcLn8go/mChCvxzVCQEL89cvxHH6h53214CVYOAie6ps
         HQcaWvtAp+35Mq9X6Jq11M1c/y5RpoL3aPfJmmZic2o4LQ0e0oBcy5+IYAQDSdSwqCoY
         c9CoyQscc9nMi0imuH9j39yuE+Cfj8J5UoKlfoSY6LCWZ9w0AGk3m6VYmYcszVmgTj6i
         DbktLNB6HB4McVidf629ykY/0W1rz1iidomCtPWXunDxrEtlgHqRH9swOfUS4YcDF19J
         RezWJ6zVkazN0IpqVFfA9fOvAUm2rqoQb3WSv8e2r1cTPupc2suflLg2rQDmX5jQWkck
         syvg==
X-Gm-Message-State: AFqh2krLAAXmqnBOKcfVq/qBsX54AfioqgwrKMh2TgAnq5Dv2+VINDD7
	P82Ho6iAREYgM89BzlyrXvA=
X-Google-Smtp-Source: AMrXdXugxK4PFsdzTd/UHoK8RxYysLnHvBypPqNsFOLw2i8sToqUWkmMdk+igU0evl+DXigFtmj6XA==
X-Received: by 2002:a05:6808:404b:b0:36c:cc25:8bc4 with SMTP id cz11-20020a056808404b00b0036ccc258bc4mr1526769oib.26.1674079170018;
        Wed, 18 Jan 2023 13:59:30 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bx19-20020a056830601300b006619533d1ddsm12112404otb.76.2023.01.18.13.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:59:28 -0800 (PST)
Message-ID: <f3018ef3-98a8-c6fd-be04-aaf7dfe11d13@gmail.com>
Date: Wed, 18 Jan 2023 15:42:28 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] eapol: implement rekey support for authenticator
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230118211801.1636194-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230118211801.1636194-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/18/23 15:17, James Prestwood wrote:
> The only changes required was to set the secure bit for message 1,
> reset the frame retry counter, and change the 2/4 verifier to use
> the rekey flag rather than ptk_complete. This is because we must
> set ptk_complete false in order to detect retransmissions of the
> 4/4 frame.
> 
> Initiating a rekey can now be done by simply calling eapol_start().
> ---
>   src/eapol.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> v3:
>   * Set ek->secure to sm->rekey always to ensure retransmissions get
>     the secure bit set.
> 

All applied, thanks.

Regards,
-Denis

