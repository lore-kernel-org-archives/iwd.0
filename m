Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66F1FBA
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 02:40:41 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1278624b7c4so11951847fac.5
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 19:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=V4lK+79VR8zn4SMMA2pxOQ00nSCoCPZkHrXgYqqbQ+Q=;
        b=V61WaJC9za9YX0bhwiPOWOHAJ9WU3CM3elfERmmsHe0ZDeGTv19+BQhe/IXGLn4oe0
         TEEx3egcoKE3RyIMP69KWFZU+1KzsoV7IY8f+NiDd4plyRlurXu6uxwo9ehuStznUWhk
         Aa0sBxHTurT85HyCLGLWOftUaxfielJVCSJnxD2KFeLnXIC64jqFSby3xkNw2un2hzQY
         zcc1Gwk0cHtBlHxQ64fMN9oG9S+WiIbn1/UZuQ8ZkhRGoPmyXPxhLFyR8nDfZ/PUAAY+
         ME3QSR4iGAngxQ7lo4kQuHoN/2i7TZB8M2n17rVNLePPZB0gpyMeC8u4LBPJwykABe/8
         q3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=V4lK+79VR8zn4SMMA2pxOQ00nSCoCPZkHrXgYqqbQ+Q=;
        b=ff55naYCyeR1n1CC5oq9KN44s6CH1jANXIwvTsabEfG/pq2R1QOwABtbRzA730ParF
         xJ7WAcyUsDgY+UXQSPRg20RB7WipblOuCWFVVlzcEOKy8j1StJ55ezKI0xBNTGhQav5/
         T8F0XSpmOEKMfcl6YL93kBnyLZTQBcf5xKZbfMppNepVGR7vcxcOnH3Ij9z4+FVeo8ZE
         QSBNM8ARJcrc2lBwKmSCmt83kJI7szgvlWzobqKxl6VzRY0q4qlJb4Ol+y+o4cWT0GCQ
         uOZebrWpbHCctG/rwaniHo2GYdwHr8DrBRcQJnKYTemgn8tF5e+dfgbAVk0GsHDNtEBD
         wgNw==
X-Gm-Message-State: ACrzQf3UnLDJ7NTGKQucyn8sqpoj4khOJC/GTZ26JH3ojwxfRVZp3Ijx
	9N6ztJEYk5CQDFjyEMJbVkLMuDd6UB8=
X-Google-Smtp-Source: AMsMyM43VTnPJ3TaCSlm7Mf5FmWSU7yghHSHdBuWz5jyzj0ncgxQLboVtLeyjgjnAg0W1tkCER2Axw==
X-Received: by 2002:a05:6870:204a:b0:11e:c890:659d with SMTP id l10-20020a056870204a00b0011ec890659dmr7006066oad.163.1663814440938;
        Wed, 21 Sep 2022 19:40:40 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g20-20020a056870a71400b0011e73536301sm2557757oam.52.2022.09.21.19.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 19:40:40 -0700 (PDT)
Message-ID: <258acf4a-457b-4154-9be1-f78eb0154bdb@gmail.com>
Date: Wed, 21 Sep 2022 21:40:39 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 05/15] ft: netdev: prep for FT isolation into ft.c
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220921223158.704658-1-prestwoj@gmail.com>
 <20220921223158.704658-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220921223158.704658-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/21/22 17:31, James Prestwood wrote:
> Currently netdev handles caching FT auth information and uses FT
> parsers/auth-proto to manage the protocol. This sets up to remove
> this state machine from netdev and isolate it into ft.c.
> 
> This does not break the existing auth-proto (hence the slight
> modifications, which will be removed soon).
> 
> Eventually the auth-proto will be removed from FT entirely, replaced
> just by an FT state machine, similar to how EAPoL works (netdev hooks
> to TX/RX frames).
> ---
>   src/ft.c     | 312 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   src/ft.h     |  22 +++-
>   src/netdev.c |  28 +++--
>   3 files changed, 329 insertions(+), 33 deletions(-)
> 

<snip>

> @@ -45,6 +69,9 @@ struct ft_sm {
>   	void *user_data;
>   
>   	bool over_ds : 1;
> +
> +	uint8_t prev_bssid[6];
> +	struct l_queue *ft_auths;

Is ft_auths still needed?

>   };
>   
>   /*

<snip>

> +int ft_associate(uint32_t ifindex, const uint8_t *addr)
> +{
> +	struct netdev *netdev = netdev_find(ifindex);
> +	struct handshake_state *hs = netdev_get_handshake(netdev);
> +	struct ft_info *info;
> +	int ret;
> +
> +	/*
> +	 * TODO: Since FT-over-DS is done early, before the time of roaming, it
> +	 *       may end up that a completely new BSS is the best candidate and
> +	 *       we haven't yet authenticated. We could actually authenticate
> +	 *       at this point, but for now just assume the caller will choose
> +	 *       a different BSS.
> +	 */
> +	info = ft_info_find(ifindex, addr);
> +	if (!info)
> +		return -ENOENT;
> +
> +	ft_prepare_handshake(info, hs);
> +
> +	ret = ft_tx_reassociate(ifindex, info->frequency, info->prev_bssid);
> +
> +	/* After this no previous auths will be valid */
> +	l_queue_clear(info_list, ft_info_destroy);

So why are we clearing the entire list?  Shouldn't we be clearing it only for 
the ifindex in question?

> +
> +	return ret;
> +}
> +
> +void ft_reset(uint32_t ifindex)

I think a more descriptive name is required.  Like 
ft_purge_authentications_for_ifindex() or something? :)

> +{
> +	struct ft_info *info;
> +
> +	while ((info = ft_info_find(ifindex, NULL))) {
> +		l_queue_remove(info_list, info);

This looks like a O(n^2) loop instead of doing the purge in linear time?

> +		ft_info_destroy(info);
> +	}
> +}
> +
> +static int ft_init(void)
> +{
> +	info_list = l_queue_new();
> +
> +	return 0;
> +}
> +
> +static void ft_exit(void)
> +{
> +	if (!l_queue_isempty(info_list))
> +		l_warn("stale FT info objects found!");
> +
> +	l_queue_destroy(info_list, ft_info_destroy);
> +}
> +
> +IWD_MODULE(ft, ft_init, ft_exit);

Does netdev need an IWD_MODULE_DEPENDS on ft now?

Regards,
-Denis
