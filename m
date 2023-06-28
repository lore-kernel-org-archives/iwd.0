Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC6D532
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 20:49:14 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4003cdbd675so2299571cf.3
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687985353; x=1690577353;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqtqYMPPoPnHJRXD5VSWtN5hwSDg8pA7uAhkYXLMf0g=;
        b=Ksnu22P5h3zqIV3nWg6B93GKOPS2isvY4wDbf5THYHON6I2454eGQAvip/rHjeEeRS
         c7kVz+7qgJ8PEaXRYtCURfnbhc5j0BWQUf/LW94+Lp5MXAiND4CSP4mE58MDpstE8iyy
         xhCVii2/2a2BQ5R59KbqahwpeCCELldq4q5spXK8bIB858crUTHGzXZusEPxR/32TA/0
         iEMyoQEme0Gzyar7EVb8NL81yYmjngVKe2l3K3bro99oS6XeQqGx25jAaiBOiXlhJpIB
         3qJf4VKbeQJ5o6CjNgVV4OTkNsaGFM4LBJ+AHdODwfx69HIFZqMB+Gj5pkISQo6kcFTh
         9vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985353; x=1690577353;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqtqYMPPoPnHJRXD5VSWtN5hwSDg8pA7uAhkYXLMf0g=;
        b=Iv2jVtYxsZXNVUthzBit8N3l+hCCUnjf6SQoxcxopX8ocrQzso39Pt0jb9NOOSL5Ib
         5MAF/e//gg6ETInrg/Quoczo1pdBCEBxq1Ryv8uLpbqCuvD+sXXxnWDZ0p1fTVMNNhFy
         MEMXUIGyR8Qi3UFyd9D/z+5xySR3wyZDsgZIEdBpZ6nBMUjgyUPG8Bf9tor331Fsk5/5
         QzrGGkwkYNLSuhp9TJ3CvdRsO+rC971fXbn1YOFs1JAYLeRImqoq4xvu/PBu6C5HJdRB
         RzvtODB62RuLOGbAG1snQnmgDQiAnE30IBJWebDV2vM+8ZCLLARVidFzauDAeuqtHOBv
         4Psg==
X-Gm-Message-State: AC+VfDxPNpNr3s5NiJxdPEv9fOU/3ZhymPDc01hyY1Ya+JV+aaJRVCgp
	U7JEeDa0WxUhr/wN6i5UH0JeHq2L8W8=
X-Google-Smtp-Source: ACHHUZ7CR0/U2kbuJGNFaVOx2LkgT3rMdDKhssNfa7tNBILa6HcspgiATgKt6SQYFipFP3nhDVb9fg==
X-Received: by 2002:a05:622a:201:b0:403:1bcc:56a with SMTP id b1-20020a05622a020100b004031bcc056amr4173966qtx.11.1687985353120;
        Wed, 28 Jun 2023 13:49:13 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id n6-20020ac85a06000000b003ff251b17c8sm6338484qta.10.2023.06.28.13.49.11
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:49:12 -0700 (PDT)
Message-ID: <ecd84c5a-1be2-8d9e-4bad-da4e3c477e7d@gmail.com>
Date: Wed, 28 Jun 2023 13:49:10 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/3] hwsim: handle ADD/DEL_MAC_ADDR events
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20230628202033.2320994-1-prestwoj@gmail.com>
 <20230628202033.2320994-4-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20230628202033.2320994-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/28/23 1:20 PM, James Prestwood wrote:
> Handling these events notifies hwsim of address changes for interface
> creation/removal outside the initial namespace as well as address
> changes due to scanning address randomization.
> 
> Interfaces that hwsim already knows about are still handled via
> nl80211. But any interfaces not known when ADD/DEL_MAC_ADDR events
> come will be treated specially.
> 
> For ADD, a dummy interface object will be created and added to the
> queue. This lets the frame processing match the destination address
> correctly. This can happen both for scan randomization and interface
> creation outside of the initial namespace.
> 
> For the DEL event we handle similarly and don't touch any interfaces
> found via nl80211 (i.e. have a 'name') but need to also be careful
> with the dummy interfaces that were created outside the initial
> namespace. We want to keep these around but scanning MAC changes can
> also delete them. This is why a reference count was added so scanning
> doesn't cause a removal.
> 
> For example, the following sequence:
> 
> ADD_MAC_ADDR (interface creation)
> ADD_MAC_ADDR (scanning started)
> DEL_MAC_ADDR (scanning done)
> ---
>   tools/hwsim.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 132 insertions(+)
> 
> diff --git a/tools/hwsim.c b/tools/hwsim.c
> index 2fee9b19..5cb28624 100644
> --- a/tools/hwsim.c
> +++ b/tools/hwsim.c
> @@ -440,6 +440,7 @@ struct interface_info_rec {
>   	uint8_t addr[ETH_ALEN];
>   	char *name;
>   	uint32_t iftype;
> +	int ref;
>   };
>   
>   static struct l_queue *radio_info;
> @@ -515,6 +516,14 @@ static bool interface_info_match_id(const void *a, const void *b)
>   	return rec->id == id;
>   }
>   
> +static bool interface_info_match_addr(const void *a, const void *b)
> +{
> +	const struct interface_info_rec *rec = a;
> +	const uint8_t *addr = b;
> +
> +	return memcmp(rec->addr, addr, ETH_ALEN) == 0;
> +}
> +
>   static const char *radio_get_path(const struct radio_info_rec *rec)
>   {
>   	static char path[15];
> @@ -1682,6 +1691,123 @@ static void hwsim_frame_event(struct l_genl_msg *msg)
>   	process_frame(frame);
>   }
>   
> +static bool get_tx_rx_addrs(struct l_genl_msg *msg, const uint8_t **tx_out,
> +				const uint8_t **rx_out)
> +{
> +	struct l_genl_attr attr;
> +	uint16_t type, len;
> +	const void *data;
> +	const uint8_t *tx = NULL, *rx = NULL;
> +
> +	if (!l_genl_attr_init(&attr, msg))
> +		return false;
> +
> +	while (l_genl_attr_next(&attr, &type, &len, &data)) {
> +		switch (type) {
> +		case HWSIM_ATTR_ADDR_TRANSMITTER:
> +			if (len != ETH_ALEN)
> +				return false;
> +
> +			tx = data;
> +			break;
> +		case HWSIM_ATTR_ADDR_RECEIVER:
> +			if (len != ETH_ALEN)
> +				return false;
> +
> +			rx = data;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (!tx || !rx)
> +		return false;
> +
> +	*tx_out = tx;
> +	*rx_out = rx;
> +
> +	return true;
> +}
> +
> +static void hwsim_add_mac_event(struct l_genl_msg *msg)
> +{
> +	const uint8_t *tx = NULL, *rx = NULL;
> +	struct radio_info_rec *radio_rec;
> +	struct interface_info_rec *interface_rec;
> +
> +	if (!get_tx_rx_addrs(msg, &tx, &rx))
> +		return;
> +
> +	/* No radio matches the TX address, hwsim must not have created it */
> +	radio_rec = l_queue_find(radio_info, radio_info_match_addr1, tx);
> +	if (!radio_rec)
> +		return;
> +
> +	interface_rec = l_queue_find(interface_info,
> +					interface_info_match_addr, rx);
> +	if (interface_rec) {
> +		/* Existing interface, address changes handled via nl80211 */
> +		if (interface_rec->name)
> +			return;
> +
> +		/*
> +		 * Transient/dummy interface we already know about. This likely
> +		 * was created, then a scan changed the address temporarily.
> +		 * Reflect this change and increment the ref so the following
> +		 * DEL event doesn't destroy it
> +		 */
> +		__atomic_fetch_add(&interface_rec->ref, 1, __ATOMIC_SEQ_CST);
> +		memcpy(interface_rec->addr, rx, ETH_ALEN);

Just realized this memcpy is redundant since the interface_rec wouldn't 
match unless the address was already the same. This case only happens 
when randomization is off and is a consequence of the kernel having two 
separate addresses (one prefixed with 0x4, still not sure why they do 
this). So you get the following events (say the perm address is 
02:00:00:00:00:00):

ADD(tx=42:00:00:00:00:00, rx=02:00:00:00:00:00) (Interface Creation)
ADD(tx=42:00:00:00:00:00, rx=02:00:00:00:00:00) (Scanning started)
DEL(tx=42:00:00:00:00:00, rx=02:00:00:00:00:00) (Scanning ended)

When scan randomization is enabled it will create a completely separate 
dummy interface and the DEL event can freely delete that.

I can remove this in v2 if you have additional comments

> +		return;
> +	}
> +
> +	/*
> +	 * Create a dummy interface entry for this address that only contains
> +	 * the radio and address. This is either a transient entry due to scan
> +	 * randomization or an interface created outside this namespace.
> +	 */
> +	interface_rec = l_new(struct interface_info_rec, 1);
> +	interface_rec->radio_rec = radio_rec;
> +	interface_rec->ref = 1;
> +	memcpy(interface_rec->addr, rx, ETH_ALEN);
> +
> +	l_queue_push_tail(interface_info, interface_rec);
> +}
> +
> +static void hwsim_del_mac_event(struct l_genl_msg *msg)
> +{
> +	const uint8_t *tx = NULL, *rx = NULL;
> +	struct radio_info_rec *radio_rec;
> +	struct interface_info_rec *interface_rec;
> +
> +	if (!get_tx_rx_addrs(msg, &tx, &rx))
> +		return;
> +
> +	/* No radio matches the TX address, hwsim must not have created it */
> +	radio_rec = l_queue_find(radio_info, radio_info_match_addr1, tx);
> +	if (!radio_rec)
> +		return;
> +
> +	interface_rec = l_queue_find(interface_info,
> +						interface_info_match_addr, rx);
> +	if (!interface_rec)
> +		return;
> +
> +	/*
> +	 * This change is handled via nl80211 so we don't want to touch this
> +	 * interface here.
> +	 */
> +	if (interface_rec->name)
> +		return;
> +
> +	if (__atomic_sub_fetch(&interface_rec->ref, 1, __ATOMIC_SEQ_CST))
> +		return;
> +
> +	l_queue_remove(interface_info, interface_rec);
> +	l_free(interface_rec);
> +}
> +
>   static void hwsim_unicast_handler(struct l_genl_msg *msg, void *user_data)
>   {
>   	uint8_t cmd;
> @@ -1695,6 +1821,12 @@ static void hwsim_unicast_handler(struct l_genl_msg *msg, void *user_data)
>   	case HWSIM_CMD_FRAME:
>   		hwsim_frame_event(msg);
>   		break;
> +	case HWSIM_CMD_ADD_MAC_ADDR:
> +		hwsim_add_mac_event(msg);
> +		break;
> +	case HWSIM_CMD_DEL_MAC_ADDR:
> +		hwsim_del_mac_event(msg);
> +		break;
>   	default:
>   		break;
>   	}
