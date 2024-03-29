var SetIntervalMixin = {
  componentWillMount: function() {
    this.intervals = [];
  },
  setInterval: function() {
    this.intervals.push(setInterval.apply(null, arguments));
  },
  componentWillUnmount: function() {
    this.intervals.forEach(clearInterval);
  }
};

var Pie = React.createClass({
  mixins: [SetIntervalMixin],
  getInitialState: function() {
    return {
      cached_total_votes: this.props.cached_total_votes,
      myPieChart: null,
      labels: this.props.labels,
      data: this.props.data,
      backgroundColors: this.props.backgroundColors,
      id: this.props.id
    }
  },
  getUpdatedData: function(e) {
    $.getJSON("/api/v1/polls/" + this.state.id,
      function(json) {
        var newData = new Array();
        for (var key in json.options) {
          newData.push(json.options[key]);
        }
        this.setState({data: newData, cached_total_votes: json.cached_total_votes});
      }.bind(this)
    );
    this.state.myPieChart.data.datasets[0].data = this.state.data;
    this.state.myPieChart.update();
  },
  componentDidMount: function() {
    setInterval(this.getUpdatedData, 10000);
    var ctx = document.getElementById("myPie").getContext("2d");
    var myPieChart = new Chart(ctx,{
      type: 'pie',
      data: {
        labels: this.state.labels,
        datasets: [
          {
            data: this.state.data,
            backgroundColor: this.state.backgroundColors
          }
        ]
      }
    });
    this.setState({myPieChart: myPieChart});
  },
  render: function() {
    return(
      <p className="center light">Total votes: {this.state.cached_total_votes}</p>
    )
  }
});