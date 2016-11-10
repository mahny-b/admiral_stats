module GlobalHelper
  # 与えられた割合の値から、パーセント表記を返します。
  # nil の場合は 0 % を返します。
  def parcentage_by_rate(rate)
    rate.nil? ? '0 %' : "#{rate} %"
  end

  # 入手率の値に基づいて、CSS のクラス名を返します。
  def css_class_by_rate(rate)
    if rate.nil? or rate < 10
      'rate-tuchinoko'
    elsif rate < 30
      'rate-veryrare'
    elsif rate < 50
      'rate-rare'
    else
      'rate-common'
    end
  end

  # 攻略率をグラフ表示するための JSON を返します。
  def data_chart_cleared_rate(total_num, cleared_nums, levels)
    res = [
        { name: '未攻略', y: ((total_num - cleared_nums.values.sum).to_f / total_num * 100).round(1), color: '#AAAAAA' }
    ]

    levels.each do |level|
      res << {
          name: "「#{difficulty_level_to_text(level)}」攻略済",
          y: (cleared_nums[level].to_f / total_num * 100).round(1),
          color: difficulty_level_to_color(level),
      }
    end

    res.to_json
  end

  # 周回数をグラフ表示するための JSON を返します。
  def series_chart_cleared_loop_counts(total_num, cleared_loop_counts, levels)
    res = []

    levels.each do |level|
      res << {
          name: difficulty_level_to_text(level),
          data: cleared_loop_counts[level].map{|cnt| (cnt.to_f / total_num * 100).round(1) },
          color: difficulty_level_to_color(level),
      }
    end

    res.to_json
  end
end
