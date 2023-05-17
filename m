Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C317C8
	for <iwd@lists.linux.dev>; Wed, 17 May 2023 01:16:21 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ab087111faso116735a34.3
        for <iwd@lists.linux.dev>; Tue, 16 May 2023 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684286180; x=1686878180;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3fkzaL29V4Q9ZAik986ICgss3zlbavWnaAsTfhhxKo=;
        b=MSdDxlB5e56U/RYeGjAM1NhYU6dROpfh33hE6FA+oyqSTYpQHGlaMGCp4V/0AY/Ln0
         iJzv5AzjIqvkbnREGKCi2EMRIa+bC96DygWQi9u75p+9qI2c/JfxpQ8OkyRH9cJrWMty
         OeF/gUAzaxXeDru7kRk1WVsT1ZRf607tNI4547RZnlp1PsyzxAtHUCFojHk9Nfg4Tiuk
         fsm9bKqYafzr4Ya61rO3HI7Kx+Q1QxNTxIJ0Dy2Yrx5tT1fxbDdJtZKusHbTKTJg5vlG
         6VN/LxYRHs8vTlL3SyVmIs0TaGRRLgtNMOQO5KeJ0UiAFb/Q43TJ2eigHlg963dwU5QQ
         DOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684286180; x=1686878180;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3fkzaL29V4Q9ZAik986ICgss3zlbavWnaAsTfhhxKo=;
        b=hyDKltujCKaXKHy7qdJM62aCaHDQHoHyAwlhF2V+6rVd/pIHAYgN/WXHdcJ1fgGjeT
         +1BZpmoXkeey155Y4BbtDV6dTUSx6O6PwvOiq0PXx9BZ6f4eBD3sf9OhZtCxYTWoxT09
         pyh5FxVFXztZ9r8pjhkA8mCq5i2WCH+BZLuOyDMSvxzcXstCi1hlTsB9oNCjIYmNLrw6
         orsjicW+tW/kx5BaYMFfN+X6Fn/mUUEvq4Una/6n399STKdCXu48B2m2WfCJTvoak4zM
         kmQ8JIE6XKbzFprX1TWJwu2Vi+AIsWjsGTwYvEbmxwdoHAyLoke+o2bqkJtTIwS6Rvp4
         YJyw==
X-Gm-Message-State: AC+VfDxML/KSzX75oGTeae5JJP0YU1UWhkGAT3fZib9bD66/o9tAenc9
	Ivy12qZbtO1XpT+NxJ+xe9SqZSMMXBM=
X-Google-Smtp-Source: ACHHUZ7abn8OU3cxqn0OOwQKeUXb15SpzCTu8LLf/RppEJJYNj7ClcwY/Loiurd/6gNyZGNVFT+xkQ==
X-Received: by 2002:a05:6870:d899:b0:192:d064:7c9a with SMTP id dv25-20020a056870d89900b00192d0647c9amr16577585oab.2.1684286180357;
        Tue, 16 May 2023 18:16:20 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d20-20020a056830139400b006ab37d0b2e8sm6825057otq.74.2023.05.16.18.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 18:16:19 -0700 (PDT)
Message-ID: <66b5f9a2-33b8-efc2-b316-87d49aac787e@gmail.com>
Date: Tue, 16 May 2023 20:16:18 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] wiphy: make wiphy work queue reentrant
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230511185251.79563-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230511185251.79563-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/11/23 13:52, James Prestwood wrote:
> In some situations its convenient for the same work item to be
> inserted (rescheduled) while its in progress. FT for example does
> this now if a roam fails. The same ft_work item gets re-inserted
> which, currently, is not safe to do since the item is modified
> and removed once completed.
> 
> Currently FT reschedules the same work item in the 'do_work'
> callback but this patch actually allows for rescheduling as long
> as the item is currently running, even if do_work has returned and
> waiting for wiphy_radio_work_done.
> 
> A few new flags were added to the radio work item. One which is
> set when the item is running which prevents other items from being
> inserted ahead (previously done with priority=INT_MIN). This is
> needed since we cannot modify the priority anymore in case the item
> is being rescheduled.

This seems way too complicated.

> 
> The another flag is set when the item was rescheduled. Once the
> item is finished the 'rescheduled' flag is checked and the item
> will be removed and re-inserted into the queue if needed.
> ---
>   src/wiphy.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----------
>   src/wiphy.h |  2 ++
>   2 files changed, 57 insertions(+), 14 deletions(-)
> 

<snip>

> @@ -2583,7 +2594,7 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
>   	 * Ensures no other work item will get inserted before this one while
>   	 * the work is being done.
>   	 */
> -	work->priority = INT_MIN;
> +	work->running = true;
>   
>   	l_debug("Starting work item %u", work->id);
>   

Can't you simply take note of the current item id, set the priority, take it off 
the queue here, prior to starting.

> @@ -2592,7 +2603,12 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
>   	wiphy->work_in_callback = false;
>   

If done and work id changed, there's nothing to do.

If done, then proceed as now.

If not done, reinsert the work to the head.

>   	if (done) {
> -		work->id = 0;
> +		bool rescheduled = work->rescheduled;
> +
> +		work->running = false;
> +
> +		if (!rescheduled)
> +			work->id = 0;
>   
>   		l_queue_remove(wiphy->work, work);
>   
> @@ -2600,26 +2616,49 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
>   		destroy_work(work);

I'm really not sure this makes sense.  You are calling destroy on an item you 
just potentially reinserted.  I think a reinserted item should not trigger the 
destroy.  The caller has full control over the item anyway, so they can take 
care of this on their end.  In fact, I'd still think that the caller should use 
a different API for this to be absolutely clear, even if it is just 
wiphy_radio_work_insert() with some extra checks.

Regards,
-Denis
