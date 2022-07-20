Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17301C3C
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 02:51:46 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-10d83692d5aso988289fac.1
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CLPb0o7RUKnNW5DLtJ/E10wtD/MbhEYUYzi5/dK+93A=;
        b=bpKHtrt9JHvs8ixz57vrOa8ybU1YHqniTZ920w7nRrQBfuLnbgkwOT2V7nnEy7MyqI
         mtxKuU8WtUwZUMfwk7eJ6mZLSrAJFjpCef3HnXD3kpnJy0pXvDVkUB4E/hNGOLBHFDA/
         TVua+yJKy7RMBOkTCHlUtVF7g/sWmW2c9azsIXKQMpz4XqM2S0GnqgF2LTnJzycR8vZR
         s0BrQmgRFS/dKEiKab0Rkwro4ns/5HIrASM4+s9QrSMd2IuVi2vC2KMw9k8watJ4V0QV
         HPB0DmFA1yLSFBpA7LW5mtw7vV7B1anWyK17ysHcQ2/6OBrZfVr80HY0iMhdMEaal1S8
         A7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CLPb0o7RUKnNW5DLtJ/E10wtD/MbhEYUYzi5/dK+93A=;
        b=dNJ10TKpYh0T2PPnbxMFaawEwh2GUdYadk0+bIgFL0h9dYdDlaNO1twO+4O78SD87g
         5qy/q9lCth14fBJffu1U1GvNFWibYpFctS6HE6awfUgyuMWMVT9tgTDxvsDZ231J+QS4
         MnM2wPbL1YpOU2CwhfQrZzyDrjne1h/idPUaWD4TAfgt0TBEMvBW6T62XNfVVrVyUoOd
         515AlS8Fs/SzS+vtwfUIQM3rZ3uX5SxbRD48xpd6GCqrghRh0afPzAj4gb4UOOswfQRT
         d3+6EmIg9iqwZ9+PJRPV+AK5NR/dWcC+XypLJ6RSwoUIUNQ5tXRL3UfhtPBUISz85FLE
         ybCQ==
X-Gm-Message-State: AJIora/Nee9uZfbEVP+Nmz5LQ376X2nINfMecjqwxeltlf+GI1u5PCw7
	ChdpPlyc3CT+WAya/kblUN4=
X-Google-Smtp-Source: AGRyM1tHXbkz+AHcbtyWvJeK8pAmh4K4updFUF7aCYV811KUKNSCcEqjmjwYI0uIShFFWUeQWjWOHg==
X-Received: by 2002:a05:6870:c093:b0:10c:4f6f:d0ab with SMTP id c19-20020a056870c09300b0010c4f6fd0abmr1426845oad.194.1658285505824;
        Tue, 19 Jul 2022 19:51:45 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id c5-20020a056830000500b0061ca5495cc2sm2813361otp.30.2022.07.19.19.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 19:51:45 -0700 (PDT)
Message-ID: <2b2794fd-e207-cea9-d131-258f0ef6fff2@gmail.com>
Date: Tue, 19 Jul 2022 21:36:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] band: add band_estimate_he_rx_rate
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220719233924.559329-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220719233924.559329-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/19/22 18:39, James Prestwood wrote:
> Similar to the HT/VHT APIs, this estimates the data rate based on the
> HE Capabilities element, in addition to our own capabilities. The
> logic is much the same as HT/VHT. The major difference being that HE
> uses several MCS tables depending on the channel width. Each width
> MCS set is checked (if supported) and the highest estimated rate out
> of all the MCS sets is used.
> ---
>   src/band.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>   src/band.h |   3 +-
>   2 files changed, 238 insertions(+), 9 deletions(-)
> 
> v2:
>   * Removed confusing loop to iterate widths. Replaced with 3 if blocks
>     that calculate the rate based on the MCS set
>   * Use OFDM enum instead of band_chandef_width. This did require a special
>     case for 80+80, but really simplifies everything else.
> 

<snip>

> +
> +/*
> + * Finds the best width supported according to capabilities. The 802.11ax spec
> + * has a separate MCS set for 80+80, but in the end 160 and 80+80 are treated
> + * the same in terms of the rate tables. This MCS set still needs to be checked
> + * though which is why the mcs80p80 flag is set in this case.
> + */
> +static enum ofdm_channel_width find_he_width_offset(enum band_freq freq,
> +				const struct band_he_capabilities *he_cap,
> +				const uint8_t *he_phy, bool *mcs80p80)
> +{
> +
> +	uint8_t own_width_set = bit_field(he_cap->he_phy_capa[0], 1, 7);
> +	uint8_t peer_width_set = bit_field(he_phy[0], 1, 7);

Why not just & these together and then test just the result?

> +	enum ofdm_channel_width max_width = OFDM_CHANNEL_WIDTH_20MHZ;
> +
> +	/*
> +	 * 802.11ax Table 9-322b
> +	 */
> +	switch (freq) {
> +	case BAND_FREQ_2_4_GHZ:
> +		/* B0 indicates support for 40MHz */
> +		if (test_bit(&peer_width_set, 0) && test_bit(&own_width_set, 0))

These test_bit lines end up over 80 chars...

> +			max_width = OFDM_CHANNEL_WIDTH_40MHZ;
> +
> +		break;
> +	case BAND_FREQ_5_GHZ:
> +	case BAND_FREQ_6_GHZ:
> +		/* B1 indicates support for 40MHz and 80MHz, choose 80 */
> +		if (test_bit(&peer_width_set, 1) && test_bit(&own_width_set, 1))
> +			max_width = OFDM_CHANNEL_WIDTH_80MHZ;
> +
> +		/* B2 indicates support for 160MHz */
> +		if (test_bit(&peer_width_set, 2) && test_bit(&own_width_set, 2))
> +			max_width = OFDM_CHANNEL_WIDTH_160MHZ;
> +
> +		/* B3 indicates support for 80+80MHz */
> +		if (test_bit(&peer_width_set, 3) &&
> +						test_bit(&own_width_set, 3)) {
> +			max_width = OFDM_CHANNEL_WIDTH_160MHZ;
> +			*mcs80p80 = true;

If we wanted to be extra paranoid, I guess we should also check that bit 3 is 
set IFF bit 2 is set and IFF bit 1 is set.  Maybe validating this and the 
presence of RX/TX MCS Maps for 160/80+80 fields should be done at entry to 
band_estimate_he_rx_rate();

> +		}
> +
> +		break;
> +	}
> +
> +	return max_width;
> +}
> +
> +/*
> + * HE data rate is calculated based on 802.11ax - Section 27.5
> + */
> +int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
> +				int32_t rssi, uint64_t *out_data_rate)
> +{
> +	enum ofdm_channel_width width;
> +	const struct band_he_capabilities *he_cap = NULL;
> +	const struct l_queue_entry *entry;
> +	const uint8_t *rx_map;
> +	const uint8_t *tx_map;
> +	bool mcs80p80 = false;
> +	uint64_t rate = 0;
> +	uint64_t new_rate = 0;
> +
> +	if (!hec || !band->he_capabilities)
> +		return -EBADMSG;
> +
> +	for (entry = l_queue_get_entries(band->he_capabilities);
> +						entry; entry = entry->next)
> +	{

That's not our style.  Also, maybe we should introduce QUEUE_FOREACH macro or 
something?  We can do this later I guess.

> +		const struct band_he_capabilities *cap = entry->data;
> +
> +		/*
> +		 * TODO: Station type is assumed here since it is the only
> +		 *       consumer of these data rate estimation APIs. If this
> +		 *       changes the iftype would need to be passed in.
> +		 */
> +		if (he_cap->iftypes & (1 << NETDEV_IFTYPE_STATION)) {
> +			he_cap = cap;
> +			break;
> +		}
> +	}
> +
> +	if (!he_cap)
> +		return -ENOTSUP;
> +
> +	/* The maximum width sets where to stop checking MCS sets */
> +	width = find_he_width_offset(band->freq, he_cap, hec + 8, &mcs80p80);
> +

What about just checking the capability bits in-line to this function? Something 
like:

if (test_bit(intersected_caps, 3)) {
	find_rate_he(..., OFDM_CHANNEL_WIDTH_160MHZ);
}

if (test_bit(intersected_caps, 2)) {
	find_rate_he(..., OFDM_CHANNEL_WIDTH_160MHZ);
}

if (test_bit(intersected_caps, 1))
	max_width = OFDM_CHANNEL_WIDTH_80;

if (test_bit(intersected_caps, 0))
	max_width = OFDM_CHANNEL_WIDTH_40;

> +	/*
> +	 * The HE-MCS maps are 19 bytes into the HE Capabilities IE, and
> +	 * alternate RX/TX every 2 bytes. Start the TX map 19 + 2 bytes
> +	 * into the MCS set. For each MCS set find the best data rate.
> +	 *
> +	 * Note: Since 'hec' is an extended IE index 0 is actually the length
> +	 *       since wiphy offsets data - 2.
> +	 */
> +	rx_map = he_cap->he_mcs_set;
> +	tx_map = hec + 21;
> +
> +	/* 80+80MHz MCS set */
> +	if (mcs80p80) {
> +		/* 21 + 8 bytes into the IE, plus 2 for the MCS set itself */
> +		if (hec[0] < 31)
> +			return -EBADMSG;
> +
> +		if (find_rate_he(rx_map + 8, tx_map + 8,
> +				OFDM_CHANNEL_WIDTH_160MHZ, rssi, &new_rate))
> +			rate = new_rate;
> +	}
> +
> +	/* 160MHz MCS set */
> +	if (width == OFDM_CHANNEL_WIDTH_160MHZ) {
> +		/* 21 + 4 bytes into the IE, plus 2 for the MCS set itself */
> +		if (hec[0] < 27)
> +			return -EBADMSG;
> +
> +		if (find_rate_he(rx_map + 4, tx_map + 4,
> +				OFDM_CHANNEL_WIDTH_160MHZ, rssi, &new_rate) &&
> +				new_rate > rate)
> +			rate = new_rate;
> +	}
> +
> +	/* <= 80MHz MCS set, length checked as this field always exists */
> +	if (find_rate_he(rx_map, tx_map, width, rssi, &new_rate) &&
> +					new_rate > rate)
> +		rate = new_rate;

And looks like this last part should be done in a loop for 80,40,20 (max_width) 
in the case of 5G/6G and 40/20 in the case of 2.4G?  Similar to how VHT is done?

I think in theory you could have a RSSI where the best rate would be at a lower 
channel width...?

Some unit tests would also be nice to verify this.

> +
> +	if (!rate)
> +		return -EBADMSG;
> +
> +	*out_data_rate = rate;
> +
> +	return 0;
> +}
> +

Regards,
-Denis
